#!/bin/bash
set -e

apt update -y
apt install -y nodejs npm git

echo "${backend_ip} backend" >> /etc/hosts

cd /home/ubuntu
git clone ${github_repo}
chown -R ubuntu:ubuntu AWS-Deployment

cd AWS-Deployment/frontend
npm install
nohup npm start > express.log 2>&1 &

