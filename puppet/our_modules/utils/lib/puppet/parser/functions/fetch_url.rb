module Puppet
  module Parser
    module Functions
      newfunction(
        :fetch_url,
        :type => :rvalue,
        :doc => ' Fetch a url and returns the response body as a string'
      ) do |args|
        raise(
          Puppet::ParseError, 'fetch_url(): Wrong number of arguments ' +
            'need at least one'
        ) if args.size == 0
        url = args.first
        Net::HTTP.get(URI(url))
      end
    end
  end
end
