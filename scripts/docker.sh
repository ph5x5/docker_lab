#!/bin/bash
# Building images
cd /opt/docker/dockerfiles/tomcat
docker build . -t amurzich/tomcat
cd /opt/docker/dockerfiles/tomcat-volume
docker build . -t amurzich/tomcat-volume
cd /opt/docker/dockerfiles/nginx
docker build . -t amurzich/nginx
cd /opt/docker/dockerfiles/nginx-volume
docker build . -t amurzich/nginx-volume

# Running images
docker run -it --name tomcat-volume -P -d amurzich/tomcat-volume
docker run -it --name nginx-volume -P -d amurzich/nginx-volume
docker run -it --volumes-from tomcat-volume -d --name tomcat amurzich/tomcat
docker run -it --volumes-from nginx-volume -d -P --name nginx --link tomcat:tomcat -p 80:80 amurzich/nginx