Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "1024"
    config.vm.provision "shell", path: "config_allVMs.sh"
  end
  
  config.vm.define "server1" do |server1|
    server1.vm.hostname="server1"
    server1.vm.network "private_network", ip: "172.16.0.10"
    server1.vm.provision "shell", path: "config_server1.sh"
    server1.vm.provision "shell", inline: "sudo echo '172.16.0.11 server2 server2'>> /etc/hosts"
  end
  
  config.vm.define "server2" do |server2|
    server2.vm.hostname="server2"
    server2.vm.network "private_network", ip: "172.16.0.11"
    server2.vm.provision "shell", inline: "sudo echo '172.16.0.10 server1 server1'>> /etc/hosts"
  end
  
end
