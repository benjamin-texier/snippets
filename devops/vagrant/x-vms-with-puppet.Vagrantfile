# Example 6
#
# Pulling out all the stops with cluster of seven Vagrant boxes.
#
domain   = 'example.com'

nodes = [
  { :hostname => 'proxy',   :ip => '192.168.0.42', :box => 'precise32' },
  { :hostname => 'db',      :ip => '192.168.0.43', :box => 'precise32' },
  { :hostname => 'web1',    :ip => '192.168.0.44', :box => 'precise32' },
  { :hostname => 'web2',    :ip => '192.168.0.45', :box => 'precise32' },
  { :hostname => 'static1', :ip => '192.168.0.46', :box => 'precise32' },
  { :hostname => 'static2', :ip => '192.168.0.47', :box => 'precise32' },
  { :hostname => 'cache',   :ip => '192.168.0.48', :box => 'precise32' },
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = node[:box]
      nodeconfig.vm.hostname = node[:hostname] + ".box"
      nodeconfig.vm.network :private_network, ip: node[:ip]

      memory = node[:ram] ? node[:ram] : 256;
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.customize [
          "modifyvm", :id,
          "--cpuexecutioncap", "50",
          "--memory", memory.to_s,
        ]
      end
    end
  end

  config.vm.provision :shell, :path => "bootstrap.sh"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "main.pp"
    puppet.module_path = "puppet/modules"
  end
end
