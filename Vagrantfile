# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_VERSION = 2

Vagrant.configure(VAGRANT_VERSION) do |config|

  config.vm.define "rt" do |rt|
    
    rt.vm.box = "debian7"
    rt.vm.host_name = "rt.mf"

    rt.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      vb.customize ["modifyvm", :id, "--name", "rt" ]
    end

    rt.vm.network :forwarded_port, guest: 80, host: 8080
    rt.vm.network :forwarded_port, guest: 443, host: 4443
    rt.vm.network :forwarded_port, guest: 389, host: 3389

  end

  config.vm.provision "shell", path: "script.sh"

end
