!#/bin/bash
flag=1
while $flag do
if [[ -d /vagrant]]; then
if [[ -f /vagrant/server2_vm.pub]]; then
flag=0
cat /vagrant/server2_vm.pub > /home/vagrant/.ssh/authorized_keys
cat /vagrant/server2_vm.pub > /home/vagrant/.ssh/known_hosts
exit 0
fi
fi
sleep 1
done
