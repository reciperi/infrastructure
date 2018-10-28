require 'open-uri'

module Locb
  module CLI
    class Setup < Thor
      SYSTEM = /darwin/ =~ RUBY_PLATFORM ? 'darwin' : 'linux'

      desc 'vagrant', 'Installs vagrant'
      def vagrant
        check_or_install('vagrant')
      end

      desc 'virtualbox', 'Installs virtualbox'
      def virtualbox
        return if SYSTEM == 'linux'
        check_or_install('virtualbox')
      end

      desc 'ansible', 'Installs ansible, required for bootstraping'
      def ansible
        check_or_install('ansible')
      end

      desc 'all', 'Installs all dependencies'
      def all
        invoke 'vagrant'
        invoke 'virtualbox'
        invoke 'ansible'
        fill_private_key
        setup_hosts
        say 'Done done!', :green
      end

      default_task :all

      no_tasks do

        def setup_hosts
          hosts = File.read('/etc/hosts')
          description = '# DEVENV Managed by saltynpepper infrastructure'
          entry = "#{DEVENV_IP} #{HOSTS}"
          return if (hosts.include?(description) && hosts.include?(entry))
          `echo '#{description}' | sudo tee -a /etc/hosts`
          `echo '#{entry}' | sudo tee -a /etc/hosts`
        end

        def fill_private_key
          return if File.exist?(PRIVATE_KEY_FILE)

          say 'No private key found!', [:red, :bold]
          say 'Puppet uses eyaml for encrypting/decrypting keys, which in turn uses PKCS#7. For that to work we need'
          say 'a pair of keys, the public is already in the repo, but the private one is supposed to be in:'
          say
          say PRIVATE_KEY_FILE, :bold
          say
          say 'Please tell a coworker to give it to you so we can keep on doing the creation process, you can either paste it in here'
          say 'or cancel this script and restart it after the file is created'
          pk = ask_multiline('PASTE HERE: (and hit enter twice when finished)')
          File.write(PRIVATE_KEY_FILE, pk)
        end

        def ask_multiline(message)
          say message
          bak_sep = $/
          $/ = "\n\n"
          output = STDIN.gets.chomp
          $/ = bak_sep
          output
        end

        def check_or_install(command)
          return if which(command)
          if SYSTEM == 'linux'
            say "You need to install #{command}, after solving the issue run again this script"
            exit 1
          end
          say "Installing #{command}, globally", :yellow
          say "executing: #{command}", :bold
          system(command)
        end

        # Cross-platform way of finding an executable in the $PATH.
        #
        #   which('ruby') #=> /usr/bin/ruby
        def which(cmd)
          exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
          ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
            exts.each { |ext|
              exe = File.join(path, "#{cmd}#{ext}")
              return exe if File.executable?(exe) && !File.directory?(exe)
            }
          end
          nil
        end
      end
    end
  end
end
