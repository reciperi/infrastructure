require 'json'
module Infrastructure
  # FIXME: find a better way instead of all this ../../,./
  PUPPET_DIR = File.expand_path(File.dirname(__FILE__) + '/../../../puppet')

  class Info
    def self.puppet_value(
      key,
      environment = 'production',
      hiera_file = 'hiera/hiera.yaml'
    )
      command = "cd #{PUPPET_DIR} && bundle exec puppet lookup --hiera_config=#{hiera_file} --environment=#{environment} #{key} --environmentpath environments --render-as json"
      puts command
      result = `#{command}`
      JSON.parse(result)
    rescue JSON::ParserError
      return result.chomp
    end
  end
end
