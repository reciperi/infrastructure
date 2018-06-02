##
# returns the users that belong to a group
#
class UserUtils
  class << self
    def find_group_members(groupname, group_mapping)
      group_mapping.inject([]) do |members, (user, user_info)|
        members << user if user_info['groups'].include? groupname
        members
      end
    end
  end
end

module Puppet::Parser::Functions

  newfunction(:users_for_group, :type => :rvalue, :doc => <<-EOS
    Returns the users that belong to a group
    @param [String]  group_name: Group name
    @param [Hash]    group_mapping: A hash with this structure:
                        { 'user' => { 'groups' => [groups*] } }
    EOS
  ) do |args|
    raise Puppet::ParseError, "Wrong number of parameters for users_for_group(mapping)" if args.length != 2
    group_name    = args[0]
    group_mapping = args[1]
    raise Puppet::ParseError, "group and or group_mapping cannot be nil" if !group_name || !group_mapping
    UserUtils.find_group_members(group_name, group_mapping).flatten.uniq
  end

end
