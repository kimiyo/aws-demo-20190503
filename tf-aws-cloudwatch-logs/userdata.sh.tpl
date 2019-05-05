#!/bin/bash -xe

function log() {
  echo "[$(date)]$1" | tee -a /var/log/jenkins_cloudinit.log
}

log '[INFO] JH Testing'
#curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py -O
sudo yum install awslogs

# [/var/log/messages]
# datetime_format = %b %d %H:%M:%S
# file = /var/log/messages
# buffer_duration = 5000
# log_stream_name = {instance_id}
# initial_position = start_of_file
# log_group_name = AMZ-2
