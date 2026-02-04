#!/bin/bash
set -e

# Update system
apt update -y

# FIX DNS NAME RESOLUTION (IMPORTANT)
echo "127.0.0.1 backend" | tee -a /etc/hosts

# Install dependencies
apt install -y python3 python3-venv python3-pip git nodejs npm

# Clone repo
cd /home/ubuntu
git clone https://github.com/PrathmmeshJagdale/AWS-Deployment.git
chown -R ubuntu:ubuntu AWS-Deployment

# ---------------- BACKEND (Flask) ----------------
cd AWS-Deployment/backend

python3 -m venv venv
source venv/bin/activate
pip install -r requirement.txt

# Run Flask app on port 5000
nohup python3 run.py > flask.log 2>&1 &

# ---------------- FRONTEND (Express) ----------------
cd ../frontend
npm install

# Run Express app on port 3000
nohup npm start > express.log 2>&1 &

