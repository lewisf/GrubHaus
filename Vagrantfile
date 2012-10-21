# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  config.vm.network :hostonly, "192.168.33.10"

  config.vm.forward_port 3000, 3000
  config.vm.forward_port 8000, 8010

  config.vm.customize ["modifyvm", :id, "--rtcuseutc", "on"]

  config.vm.share_folder "code", "~/grubhaus", "."

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["chef/cookbooks"]
    chef.roles_path = ["chef/roles"]
    chef.log_level = :debug
    chef.add_role "vagrant"
  end

end
