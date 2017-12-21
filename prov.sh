#!/bin/bash
# Configuration
COMPOSE = "1"

# Docker install
echo "Installing docker.."
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --enable docker-ce-edge
yum -y install docker-ce
systemctl enable docker
systemctl start docker
usermod -aG docker vagrant
mkdir -p /opt/docker
chown -R :docker /opt/docker

# Additional tools
echo "Installing additional tools"
yum install -y net-tools

# Copying dockerfiles
echo "Copying dockerfiles.."
mkdir -p /opt/docker/dockerfiles/tomcat
mkdir -p /opt/docker/dockerfiles/tomcat-volume
mkdir -p /opt/docker/dockerfiles/nginx
mkdir -p /opt/docker/dockerfiles/nginx-volume/conf
chown -R :docker /opt/docker
cp /vagrant/dockerfiles/tomcat/Dockerfile /opt/docker/dockerfiles/tomcat/
cp /vagrant/dockerfiles/nginx/Dockerfile /opt/docker/dockerfiles/nginx/
cp /vagrant/dockerfiles/tomcat-volume/Dockerfile /opt/docker/dockerfiles/tomcat-volume/
cp /vagrant/dockerfiles/nginx-volume/Dockerfile /opt/docker/dockerfiles/nginx-volume/
cp /vagrant/nginx/* /opt/docker/dockerfiles/nginx-volume/conf/

if [ "$COMPOSE" == "0" ]
then
	# Container build/run script
	echo "Bash build/run mode selected. Running.."
	cp /vagrant/scripts/docker.sh /opt/docker/docker.sh
	chmod +x /opt/docker/docker.sh
	bash /opt/docker/docker.sh
else
    # Enabling rsyslog
	yes | cp -f /vagrant/rsyslog/rsyslog.conf /etc/rsyslog.conf
	systemctl restart rsyslog
	# Docker compose install and buid/run
	echo "Compose build/run mode selected. Running.."
	sed -i 's/tomcat/172.33.0.3/' /opt/docker/dockerfiles/nginx-volume/conf/vhost.conf
	yum install -y python-pip
	pip install docker-compose
	cp /vagrant/docker-compose/docker-compose.yml /opt/docker/docker-compose.yml
	cd /opt/docker
	docker-compose up -d
fi



