FROM library/java:8u111-alpine
MAINTAINER Andrey Murzich (andrey_murzich@epam.com)
RUN \
  mkdir /opt && \
  cd /opt && \
  wget http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-8/v8.5.24/bin/apache-tomcat-8.5.24.tar.gz && \
  tar -xvf apache-tomcat-8.5.24.tar.gz
CMD ["/opt/apache-tomcat-8.5.24/bin/catalina.sh", "run"]