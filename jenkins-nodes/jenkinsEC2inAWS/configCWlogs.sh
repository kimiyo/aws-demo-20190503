#!/bin/bash -xe
#
# ex) configCWlogs.sh /jh/log/grouptest  /work/jh*.log
echo installing CloudWatch logs agent...
log_group_name=$1
log_files=$2
log_region=$3
#instance_id=$(ec2metadata --instance-id)
instance_id="`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id || die \"wget instance-id has failed: $?\"`"

sudo mkdir /work
sudo chown ec2-user /work
sudo chgrp ec2-user /work

function log() {
  sudo echo "[$(date)]$1" | sudo tee -a /work/jh_cloudwatch_init.log
}

log '[INFO] Installing AWSLogs agent'
m="log_group_name: $log_group_name, log_files: $log_files, instance_id:$instance_id"
log "$m"
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

#Change region to my region
sudo sed -i 's/us-east-1/ap-northeast-2/g' /etc/awslogs/awscli.conf


sudo service awslogsd start
sudo systemctl  enable awslogsd

log '[INFO] Completed installation of CloudWatch logs agent'
echo Completed installation of CloudWatch logs agent.
