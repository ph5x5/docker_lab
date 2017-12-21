#!/usr/bin/env ruby
Vagrant.configure("2") do |config|
  config.vm.define "docker" do |node|
    node.vm.box = "sbeliakou/centos-7.4-x86_64-minimal"
    node.vm.hostname = "docker"
    node.vm.network "private_network", ip: "192.168.56.2"
    node.vm.network "forwarded_port", guest: 80, host: 8080
    node.vm.network "private_network", type: "dhcp"
    node.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.name = "docker"
    end
    node.vm.provision "shell", path: "prov.sh"
  end
end
