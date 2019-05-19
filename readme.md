AWS Demo 2019-05-03

# Introduction

This site is to study GIT initially. In the future, I will use this site for AWS study

#Git Commands -- Apply .gitignore
  git rm -r --cached .
  git add .
  git status
  git commit -m "Apply .gitignore"
  git push

#Git Commands -- delete file/folder from the git history
  git filter-branch -f --index-filter "git rm -rf --cached --ignore-unmatch tf-aws-cloudwatch-logs/.terraform" -- --all


# CloudWatch Agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
sudo rpm -U ./amazon-cloudwatch-agent.rpm
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
1.Linux
1.EC2
StatsD daemon ->1. yes
Which port do you want StatsD daemon to listen to?
default choice: [8125]

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status
& $Env:ProgramFiles\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-ctl.ps1 -m ec2 -a status
/opt/aws/amazon-cloudwatch-agent/bin/config.json

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a stop
