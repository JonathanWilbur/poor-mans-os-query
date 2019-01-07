# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.define "ubuntuhost" do |ubuntuhost|
    ubuntuhost.vm.box = "ubuntu/bionic64"
    ubuntuhost.vm.hostname = "ubuntuhost"
    ubuntuhost.vm.box_check_update = true
  end
  config.vm.define "fedorahost" do |fedorahost|
    fedorahost.vm.box = "generic/fedora27"
    fedorahost.vm.hostname = "fedorahost"
    fedorahost.vm.box_check_update = true
    fedorahost.vm.synced_folder "./dist", "/vagrant"
  end
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "1024"
  end
end