provider "aws" {
  region = "${local.region}"
}

resource "aws_instance" "jenkinsTest" {
  ami                    = "ami-08ab3f7e72215fe91"
#   ami                    = "${data.aws_ami.amazon-linux-2.id}"
  instance_type          = "t2.micro"
  subnet_id              = "${data.aws_subnet.selected.id}"
  vpc_security_group_ids = ["${data.aws_security_group.selected.id}"]
  iam_instance_profile  = "${aws_iam_instance_profile.jh-jenkins-master.id}"
  key_name               = "${local.keypairname}"

  tags {
    Name        = "jenkinsTest"
    Created_by = "kimiyohome@gmail.com"
  }
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "${file("/Users/jonghoonkim/JHData/working/vs-workspace/jenkins-nodes/jenkinsEC2inAWS/aws02-jh-seoul.pem")}"
  }

  provisioner "file" {
    source      = "configCWlogs.sh"
    destination = "configCWlogs.sh"
  }
  provisioner "file" {
    source      = "installJenkins.sh"
    destination = "installJenkins.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x configCWlogs.sh",
      "./configCWlogs.sh /jh/log/grouptest  /work/jh*.log ap-northeast-2",
      "chmod +x installJenkins.sh",
      "./installJenkins.sh",
    ]
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.jenkinsTest.private_ip} >> private_ips.txt"
  }  
}
