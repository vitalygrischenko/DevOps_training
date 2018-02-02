Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.synced_folder ".", "/vagrant"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
  
  end
  
  # Config Server - HTTPD
  config.vm.define "apache" do |apache|
    apache.vm.hostname = "apache"
    apache.vm.network "private_network", ip: "172.16.0.10"
    apache.vm.network "forwarded_port", guest: "80", host: "8009"
    apache.vm.provision "shell", path: "config_httpd.sh"
  end

  # Config tomcat1
  config.vm.define "tomcat1" do |tomcat1|
    tomcat1.vm.hostname="tomcat1"
    tomcat1.vm.network "private_network", ip: "172.16.0.11"
    tomcat1.vm.provision "shell", path: "config_tomcat.sh"
    tomcat1.vm.provision "shell", inline: <<-SHELL
     echo -e "172.16.0.10 apache apache\n172.16.0.12 tomcat2 tomcat2" >> /etc/hosts
     echo -e "Welcome to Tomcat1" > /usr/share/tomcat/webapps/test/index.html
    SHELL
   
    
  end
  
  # Config tomcat2
  config.vm.define "tomcat2" do |tomcat2|
    tomcat2.vm.hostname="tomcat2"
    tomcat2.vm.network "private_network", ip: "172.16.0.12"
    tomcat2.vm.provision "shell", path: "config_tomcat.sh"
    tomcat2.vm.provision "shell", inline: <<-SHELL
     echo -e "172.16.0.10 apache apache\n172.16.0.11 tomcat1 tomcat1" >> /etc/hosts
     echo -e "Welcome to Tomcat2" > /usr/share/tomcat/webapps/test/index.html
    SHELL
    
  end

    
end