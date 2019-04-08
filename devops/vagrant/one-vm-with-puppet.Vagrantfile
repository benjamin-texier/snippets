Vagrant.configure("2") do |config|
    config.vm.box = "precise32"
    config.vm.hostname = "myprecise.box"
    config.vm.network :private_network, ip: "192.168.0.42"
  
    config.vm.provider :virtualbox do |vb|
      vb.customize [
        "modifyvm", :id,
        "--cpuexecutioncap", "50",
        "--memory", "256",
      ]
    end
  
    config.vm.provision :shell, :path => "bootstrap.sh"
  
    config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file = "site.pp"
      puppet.module_path = "puppet/modules"
    end
  end