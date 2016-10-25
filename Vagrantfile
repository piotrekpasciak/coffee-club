# encoding: utf-8
# This file originally created at http://rove.io/f3d6bab1d0d1fd33af47a6046c3b2666
# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 4
  end
  config.ssh.forward_agent = true
  config.ssh.forward_agent = true
  config.ssh.password = 'vagrant'
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "192.168.11.12"
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.synced_folder(
      ".", "/home/vagrant/src",
      {
          owner: "vagrant",
          group: "vagrant"
      }
  )
  config.vm.provision "shell", privileged: false, path: "provision/script.sh"
end