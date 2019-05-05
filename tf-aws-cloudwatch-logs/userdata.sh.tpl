#!/bin/bash -xe

function log() {
  echo "[$(date)]$1" | tee -a /var/log/jenkins_cloudinit.log
}

log '[INFO] JH Testing'
curl https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py -O
