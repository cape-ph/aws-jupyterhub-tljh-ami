#!/usr/bin/env bash

# Adapted from here:
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-install.html

curl -O https://s3.us-west-2.amazonaws.com/amazon-ecs-agent-us-west-2/amazon-ecs-init-latest.amd64.deb
sudo dpkg -i amazon-ecs-init-latest.amd64.deb

sudo sed -i '/After=docker.service/a After=cloud-final.service' /lib/systemd/system/ecs.service

sudo systemctl start ecs
