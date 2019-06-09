# Install Jenkins in my virtualbox


sudo apt update -y 
sudo apt install openjdk-8-jdk -y 
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add - 
## If this is not working, use 'sudo vi' command to add "deb https://pkg.jenkins.io/debian binary/" at the bottom of /etc/apt/sources.list file
echo "deb https://pkg.jenkins.io/debian binary/" >> /etc/apt/sources.list | sudo bash
sudo apt update -y
sudo apt install jenkins -y
sudo systemctl start jenkins 
sudo systemctl enable jenkins
cat /var/lib/jenkins/secrets/initialAdminPassword


