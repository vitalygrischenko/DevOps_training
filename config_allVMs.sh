#!/bin/bash
yum remove -y openssh-server openssh-clients
yum -y install openssh-server openssh-clients
systemctl restart sshd
yum install at -y