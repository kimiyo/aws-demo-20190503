#!/bin/bash -xe

function log() {
  sudo echo "[$(date)]$1" | sudo tee -a /var/log/cloudwatch_init.log
}

log '[INFO] Installing AWSLogs agent'
#curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py -O
sudo yum update -y
sudo yum install awslogs -y

sudo cp /etc/awslogs/awslogs.conf /etc/awslogs/awslogs.conf.backup_by_jh
sudo chmod 777 /etc/awslogs/awslogs.conf
sudo echo "
[general]
state_file = /var/lib/awslogs/agent-state
[/var/log/messages]
datetime_format = %b %d %H:%M:%S
file = ${log_files}
buffer_duration = 5000
log_stream_name = ${instance_id}
initial_position = start_of_file
log_group_name = ${log_group_name}
" > /etc/awslogs/awslogs.conf

sudo cat /etc/awslogs/awslogs.conf
sudo chmod 644 /etc/awslogs/awslogs.conf

sudo service awslogsd start
sudo systemctl  enable awslogsd

