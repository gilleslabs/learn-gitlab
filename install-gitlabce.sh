#!/bin/sh

  ###############  Launching GitLab ################

sudo mkdir /etc/gitlab
sudo mkdir /var/log/gitlab
sudo mkdir -p /var/opt/gitlab 

   
sudo docker run --detach \
    --hostname gitlab.example.com \
    --env GITLAB_OMNIBUS_CONFIG="external_url 'http://192.168.99.200'; gitlab_rails['lfs_enabled'] = true;" \
    -p 443:443 -p80:80 -p 10022:22 -e "GITLAB_SHELL_SSH_PORT=10022" \
    --name gitlab \
    --restart always \
    --volume /srv/gitlab/config:/etc/gitlab \
    --volume /srv/gitlab/logs:/var/log/gitlab \
    --volume /srv/gitlab/data:/var/opt/gitlab \
    gitlab/gitlab-ce:latest