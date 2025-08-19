# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|

  # Nomad Server
  config.vm.define "nserver" do |node|
  
    node.vm.box               = "gutehall/ubuntu24-04"
    node.vm.box_check_update  = false
    # node.vm.hostname          = "nserver.example.com"

    node.vm.network "private_network", ip: "192.168.59.110"

    node.vm.provider :virtualbox do |v|
      v.name    = "nserver"
      v.memory  = 1024
      v.cpus    = 2
    end

    node.vm.provider :libvirt do |v|
      v.memory  = 1024
      v.nested  = true
      v.cpus    = 2
    end
  end

  # Nomad Client
  config.vm.define "nclient1" do |node|

    node.vm.box               = "gutehall/ubuntu24-04"
    node.vm.box_check_update  = false
    # node.vm.hostname          = "nclient1.example.com"

    node.vm.network "private_network", ip: "192.168.59.111"

    node.vm.provider :virtualbox do |v|
      v.name    = "nclient1"
      v.memory  = 1024
      v.cpus    = 2
    end

    node.vm.provider :libvirt do |v|
      v.memory  = 1024
      v.nested  = true
      v.cpus    = 2
    end
  end

  # Infra node for PostgreSQL and Vault
  config.vm.define "ninfra" do |node|

    node.vm.box               = "gutehall/ubuntu24-04"
    node.vm.box_check_update  = false
    # node.vm.hostname          = "ninfra.example.com"

    node.vm.network "private_network", ip: "192.168.59.120"

    node.vm.provider :virtualbox do |v|
      v.name    = "ninfra"
      v.memory  = 2048
      v.cpus    = 2
    end

    node.vm.provider :libvirt do |v|
      v.memory  = 2048
      v.nested  = true
      v.cpus    = 2
    end
  end

end 