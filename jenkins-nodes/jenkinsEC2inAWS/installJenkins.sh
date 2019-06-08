#!/bin/bash

echo Installing Jenkins.....
sudo mkdir /work
sudo chown ec2-user /work
sudo chgrp ec2-user /work

function log() {
  sudo echo "[$(date)]$1" | sudo tee -a /work/jh_jenking_init.log
}
whoami > /work/jh-first-login.log
pwd >> /work/jh-first-login.log
log '[INFO] Installing Jenkins'
sudo chown ec2-user /work/jh_jenking_init.log
sudo chgrp ec2-user /work/jh_jenking_init.log


cd /work
sudo yum update -y
sudo yum install java-1.8.0-openjdk -y
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install jenkins -y
sudo service jenkins start
sleep 120
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
sudo cat /var/lib/jenkins/secrets/initialAdminPassword >> /work/jh_jenking_init.log

# sudo service jenkins stop

# sudo aws s3 cp s3://jh-jenkins-configuration-20190118/backup/initial/ /var/lib/jenkins  --recursive
# sudo service jenkins start


# Add crontab to do backup every 5 minutes 

cat > /work/s3-sync2.sh <<END
#!/bin/bash
#aws s3 sync /var/lib/jenkins s3://jh-jenkins-configuration-20190118/backup/latest/ --delete
function log() {
  sudo echo "[\$(date)]\$1" | sudo tee -a /work/jh_s3_sync.log
}
JENKINS_HOME=/var/lib/jenkins
S3_BUCKET=s3://jh-jenkins-configuration-20190609/backup/latest

#sudo aws s3 cp  \$S3_BUCKET/ --recursive --exclude "*" --include "*.xml"
sudo aws s3 sync  \$S3_BUCKET/ \$JENKINS_HOME/ --exclude "*" --include "*.xml"
sudo aws s3 cp  \$S3_BUCKET/identity.key.enc \$JENKINS_HOME/identity.key.enc 
sudo aws s3 cp  \$S3_BUCKET/secret.key \$JENKINS_HOME/secret.key 
sudo aws s3 cp  \$S3_BUCKET/secret.key.not-so-secret \$JENKINS_HOME/secret.key.not-so-secret 
sudo aws s3 cp  \$S3_BUCKET/secrets \$JENKINS_HOME/secrets --recursive
sudo aws s3 sync  \$S3_BUCKET/users \$JENKINS_HOME/users 
sudo aws s3 sync  \$S3_BUCKET/workflow-libs \$JENKINS_HOME/workflow-libs 
sudo aws s3 sync  \$S3_BUCKET/jobs \$JENKINS_HOME/jobs 

cd \$JENKINS_HOME
sudo chown jenkins . -R
sudo chgrp jenkins . -R

log "Job completed." 
END
chmod +x /work/s3-sync2.sh
cat /work/s3-sync2.sh >> /work/jh_jenking_init.log

#write out current crontab
sudo crontab -l > /work/mycron
#echo new cron into cron file
sudo echo "*/5 * * * * /work/s3-sync2.sh" >> /work/mycron
#install new cron file
sudo crontab /work/mycron
sudo cat /work/mycron
#rm mycron
#grep CRON /var/log/syslog

log '[INFO] Completed installation of Jenkins'
echo Completed installation of Jenkins.
