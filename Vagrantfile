VAGRANTFILE_API_VERSION = '2'.freeze
INFRASTRUCTURE_REPO = '/home/infrastructure'.freeze
HYPERVISOR = /linux/ =~ RUBY_PLATFORM ? :lxc : :virtualbox
DEVENV_ROOT=File.expand_path(__dir__ + '/../../cache/repos/')

subenvironment='devenv'
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.synced_folder './', INFRASTRUCTURE_REPO
  # config.vm.synced_folder ENV['HOME'], '/home/me', create: true

  config.ssh.forward_agent = true
  # Mac OS X rocks
  if HYPERVISOR == :virtualbox
    config.vm.define 'learning_puppet' do |vm_config|
      vm_config.vm.box = 'boxesio/xenial64-standard'
      vm_config.vm.network :private_network, ip: '10.0.4.3'
      vm_config.vm.provider 'virtualbox' do |v|
        v.memory = 3000
        v.cpus = 2
      end
    end
  end

  config.vm.provision(
    'install_puppet_and_friends',
    type: 'shell',
    path: File.join(__dir__, 'provision.sh'),
    privileged: true
  )
end
