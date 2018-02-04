#!/bin/bash
if [ -f /home/vagrant/.ssh/id_rsa.pub ]; then
cat /home/vagrant/.ssh/id_rsa.pub >> /vagrant/server2_vm.pub
cat /vagrant/server1_vm.pub > /home/vagrant/.ssh/authorized_keys
cat /vagrant/server1_vm.pub > /home/vagrant/.ssh/known_hosts

else
ssh-keygen -b 4096 -t rsa -N ""
cat /home/vagrant/.ssh/id_rsa.pub >> /vagrant/server2_vm.pub
cat /vagrant/server1_vm.pub > /home/vagrant/.ssh/authorized_keys
cat /vagrant/server1_vm.pub > /home/vagrant/.ssh/known_hosts

fi

