# -*- mode: ruby -*-
# vi: set ft=ruby :

################################################################################################################
#                                                                                                              #
# Vagrantfile for provisioning ready-to-go Gitlab-CI VMs#
#                                                                                                              #
# Author: Gilles Tosi                                                                                          #
#                                                                                                              #
# The up-to-date version and associated dependencies/project documentation is available at:                    #
#                                                                                                              #
# https://github.com/gilleslabs/learn-gitlab-ci                                                                 #
#                                                                                                              #
################################################################################################################


Vagrant.configure(2) do |config|

	config.vm.define "gitlabce" do |gitlabce|
        gitlabce.vm.box = "ubuntu/trusty64"
			config.vm.provider "virtualbox" do |v|
				v.cpus = 4
				v.memory = 8192
			end
        gitlabce.vm.hostname ="gitlab-ce"
		gitlabce.vm.network "private_network", ip: "192.168.99.100"
		gitlabce.vm.provision :shell, path: "install-docker.sh"
		gitlabce.vm.provision :shell, path: "install-gitlabce.sh"
    end
	
end