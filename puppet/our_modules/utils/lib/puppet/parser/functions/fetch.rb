module Puppet
  module Parser
    module Functions
      newfunction(:fetch, :type => :rvalue, :doc => <<-EOS
        Takes two arguments and returns the first if is defined (and not "")
        and the second otherwise
        EOS
      ) do |args|
        raise Puppet::ParseError, 'Wrong number of parameters for fetch(value, default)' if args.length != 2
        value   = args[0]
        default = args[1]
        raise Puppet::ParseError, 'default_value cannot be nil' if !default
        ( value == "" || !value )  ? default : value
      end
    end
  end
end
