# -*- mode: ruby -*-
# vi: set ft=ruby :

################################################################################################################
#                                                                                                              #
# Vagrantfile for provisioning ready-to-go Docker VM Running GitLab                                            #
#                                                                                                              #
# Author: Gilles Tosi                                                                                          #
#                                                                                                              #
# The up-to-date version and associated dependencies/project documentation is available at:                    #
#                                                                                                              #
# https://github.com/gilleslabs/learn-gitlab                                                                  #
#                                                                                                              #
################################################################################################################



######################################################################################################
#                                                                                                    #
#      Setup of $docker variable which will be used for docker VM Shell inline provisioning     #
#                                                                                                    #
######################################################################################################



$docker = <<DOCKER
echo "Build start at    :" > /tmp/build
date >> /tmp/build 

	################     Installing Docker            ###################

sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo touch /etc/apt/sources.list.d/docker.list
sudo rm /etc/apt/sources.list.d/docker.list
sudo echo deb https://apt.dockerproject.org/repo ubuntu-trusty main > /etc/apt/sources.list.d/docker.list
sudo apt-get update -y
sudo apt-get purge lxc-docker
sudo apt-cache policy docker-engine
sudo apt-get upgrade
sudo apt-get install linux-image-extra-$(uname -r) -y
sudo apt-get install docker-engine -y
sudo service docker start
sudo groupadd docker
sudo usermod -aG docker vagrant
sudo apt-get install bridge-utils -y

	################     Installing Docker-Compose            ###################

sudo apt-get -y install python-pip
sudo pip install docker-compose

	################     Updating host and ufw                ###################
	
sudo hostname 'docker.example.com'
echo "127.0.1.1 192.168.99.60 docker.example.com" | sudo tee -a /etc/hosts
sudo ufw enable -y
sudo sed -i 's|DEFAULT_FORWARD_POLICY="DROP"|DEFAULT_FORWARD_POLICY="ACCEPT"|g' /etc/default/ufw
sudo ufw reload
sudo ufw allow 22/tcp
sudo ufw allow 2375/tcp
sudo ufw allow 2376/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 8080/tcp

   ###############  Launching GitLab ################

sudo mkdir /etc/gitlab
sudo mkdir /etc/var/log/gitlab
sudo mkdir -p /var/opt/gitlab   
   
sudo docker run --detach \
    --hostname gitlab.example.com \
    --env GITLAB_OMNIBUS_CONFIG="external_url 'http://10.154.128.50/'; gitlab_rails['lfs_enabled'] = true;" \
    -p 443:443 -p80:80 -p 10022:22 -e "GITLAB_SHELL_SSH_PORT=10022" \
    --name gitlab \
    --restart always \
    --volume /srv/gitlab/config:/etc/gitlab \
    --volume /srv/gitlab/logs:/var/log/gitlab \
    --volume /srv/gitlab/data:/var/opt/gitlab \
    gitlab/gitlab-ce:latest



DOCKER


Vagrant.configure(2) do |config|

	config.vm.define "gitlab" do |docker|
        docker.vm.box = "ubuntu/trusty64"
			config.vm.provider "virtualbox" do |v|
				v.cpus = 2
				v.memory = 2048
			end
        docker.vm.network "private_network", ip: "10.154.128.50"
		docker.vm.provision :shell, inline: $docker
    end
end