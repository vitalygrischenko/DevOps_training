!#/bin/bash/
yum install java-1.8.0-openjdk -y
yum install tomcat tomcat-webapps tomcat-admin-webapps -y
mkdir /usr/share/tomcat/webapps/test
systemctl stop firewalld
systemctl enable tomcat
systemctl start tomcat