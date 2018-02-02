!#/bin/bash/
echo -e '172.16.0.11 tomcat1 tomcat1\n172.16.0.12 tomcat2 tomcat2' >> /etc/hosts
yum install httpd -y
cp /vagrant/mod_jk.so /etc/httpd/modules/
echo -e "worker.list=lb\nworker.lb.type=lb\nworker.lb.balance_workers=tomcat1, tomcat2\nworker.tomcat1.host=172.16.0.11\nworker.tomcat1.port=8009\nworker.tomcat1.type=ajp13\nworker.tomcat2.host=172.16.0.12\nworker.tomcat2.port=8009\nworker.tomcat2.type=ajp13" > /etc/httpd/conf/workers.properties
echo -e "LoadModule jk_module modules/mod_jk.so\nJkWorkersFile conf/workers.properties\nJkShmFile /tmp/shm\nJkLogFile logs/mod_jk.log\nJkLogLevel info\nJkMount /test* lb" >> /etc/httpd/conf/httpd.conf
systemctl stop firewalld
systemctl enable httpd
systemctl start httpd