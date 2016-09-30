VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu14"
  config.vm.network "forwarded_port", guest: 80, host: 4497
  config.vm.network :private_network, ip: "192.168.111.222"
  config.vm.provision :ansible do |ansible|
  	ansible.playbook = "playbook.yml"
  end

end
