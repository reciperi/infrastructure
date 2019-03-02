Facter.add('puppet_path') do
  setcode do
    File.expand_path(File.join(__FILE__, '..', '..', '..', '..'))
  end
end
