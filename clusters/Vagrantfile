# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"

  # config.vm.box_check_update = false
    config.vm.network "forwarded_port", guest: 80, host: 4746
    config.vm.network "private_network", ip: "198.168.111.222"
  # config.vm.network "public_network"
  # config.vm.synced_folder "../data", "/vagrant_data"
   config.vm.provider "virtualbox" do |vb|
     vb.gui = true
     vb.memory = "1024"
   end
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end
    config.vm.provision :ansible do |ansible|
      ansible.playbook = "playbook.yml"
    end
end
