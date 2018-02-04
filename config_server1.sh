#!/bin/bash
if [ -f /home/vagrant/.ssh/id_rsa.pub ]; then
cat /home/vagrant/.ssh/id_rsa.pub >> /vagrant/server1_vm.pub
else
ssh-keygen -b 4096 -t rsa -N ""
cat /home/vagrant/.ssh/id_rsa.pub >> /vagrant/server1_vm.pub
fi

