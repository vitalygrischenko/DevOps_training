FROM tomcat:latest
MAINTAINER Vitaly Grischenko <vitalygrischenko@gmail.com>

ARG BUILD_FOLDER=task7
ARG BUILD_VERSION=1.0.0019

RUN mkdir /usr/share/tomcat/webapps/$BUILD_FOLDER

WORKDIR /usr/share/tomcat/webapps/$BUILD_FOLDER

RUN curl -o $BUILD_FOLDER.war 'http://172.16.0.10:8081/nexus/service/local/repositories/snapshots/content/$BUILD_FOLDER/$BUILD_VERSION/$BUILD_FOLDER.war'

EXPOSE 8080

CMD ["catalina.sh", "run"]
