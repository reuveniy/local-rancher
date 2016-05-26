 # -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANT_ROOT = File.dirname(File.expand_path(__FILE__))
DOCKER_VDI = File.join(VAGRANT_ROOT, 'docker.vdi')

Vagrant.configure(2) do |config|
  config.vm.box = "dev-basebox"
  config.vm.define "ubuntu", primary:true do |node|
    node.vm.provider "virtualbox" do |vb|
       vb.memory = 12000
       vb.gui = false
#       unless File.exist?(DOCKER_VDI)
#         vb.customize ['createhd', '--filename', DOCKER_VDI, '--size', 30 * 1024]
#       end
#       vb.customize ['storageattach', :id, '--storagectl', 'SCSI Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', DOCKER_VDI]
    end
    if Vagrant.has_plugin?("vagrant-vbguest")
       config.vbguest.auto_update = false
       config.vbguest.no_remote = true
    end
    #node.vm.provision "shell", path: "install-virtualbox-guest.sh"
    if Vagrant.has_plugin?("vagrant-cachier")
       config.cache.scope = :box
    end

    if Vagrant.has_plugin?("vagrant-triggers")
       # clean up files on the host after the guest is destroyed
       config.trigger.after :destroy do
          run "rm -Rfv ~/windows/VirtualBox*/dev-basebox"
       end
       config.trigger.after :provision do
          run "rm -Rf #{ENV['HOME']}\\.apikeys"
       end
    end
  end
  config.vm.network "forwarded_port", guest: 8800, host: 8800
  config.vm.network "forwarded_port", guest: 5000, host: 5000
  config.vm.synced_folder ".", "/vagrant"
  config.vm.provision "shell", path: "scripts/runall.sh"
  config.vm.boot_timeout = 600
end
    
