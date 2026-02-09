#!/bin/bash
set -e

apt update -y
apt install -y python3 python3-venv python3-pip git

cd /home/ubuntu
git clone ${github_repo}
chown -R ubuntu:ubuntu AWS-Deployment

cd AWS-Deployment/backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirement.txt

nohup python3 run.py > flask.log 2>&1 &

