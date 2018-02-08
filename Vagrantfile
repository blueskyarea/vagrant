# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hdp2.6.2-box"
  config.vm.box_url = "./metadata.json"
  config.omnibus.chef_version = "11.4.0"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 50070, host: 50070
  config.vm.network "forwarded_port", guest: 2181, host: 2181
  config.vm.network "forwarded_port", guest: 8088, host: 8088
  config.vm.network "forwarded_port", guest: 60010, host: 60010
  config.vm.network "forwarded_port", guest: 58000, host: 58000

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.56.105"

  config.vm.provider "virtualbox" do |vb|
    # vb.gui = true
    vb.name = 'hdp2.6.2-box'
    vb.cpus = 4
    vb.memory = 4096
    opts = ['modifyvm', :id, '--natdnshostresolver1', 'on']
    vb.customize opts
  end

  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "./cookbooks"
    # Execute the following run list only at first time vagrant up
    chef.run_list = ["core-env-setup", "jdk", "apache-httpd", "hadoop-env-setup", "hadoop-start"] 
   end
end

