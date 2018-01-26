#!/bin/bash
yum remove -y openssh-server openssh-clients
yum -y install openssh-server openssh-clients
echo -e "PasswordAuthentification yes" >> /etc/ssh/ssh_conf
systemctl restart sshd