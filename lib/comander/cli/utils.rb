require 'net/ssh'
require 'tempfile'
require 'base64'

def check_ssh_agent!
  return if ssh_agent?
  say 'Error, no ssh agent found, please correct this and retry.', [:bold, :red]
  exit 1
end

def ssh_agent?
  Net::SSH::Authentication::KeyManager.new(nil).agent
end

def say_error_and_exit(message)
  say message, [:bold, :red]
  exit 1
end

def setup_agent!(identity_file, private_key)
  return unless identity_file || private_key

  if private_key
    f = Tempfile.new('private_key')
    f.write(Base64.decode64(private_key))
    identity_file = f.path
    f.rewind
    File.chmod(0600, f.path)
  end

  unless File.exist? identity_file
    say_error_and_exit "Error, #{identity_file} does not exists"
  end

  `/usr/bin/ssh-add #{identity_file}`

  unless $?.success?
    say_error_and_exit "Error, could not add identity file #{identity_file}"
  end
end
