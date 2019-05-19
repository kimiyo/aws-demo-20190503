provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "web" {
  #ami           = "ami-0c6b1d09930fac512"
  ami           = "${data.aws_ami.amazon-linux-2.id}" #amzn2-ami-hvm-2.0.20190508-arm64-gp2 - ami-0dd387866de2504e4
  instance_type = "t2.micro"
  #subnet_id = "subnet-d04b288c"
  subnet_id = "${data.aws_subnet.selected.id}"
  iam_instance_profile ="${aws_iam_instance_profile.jh05-ec2-cw-role.name}"
  key_name = "jh-us-key"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  ##vpc_security_group_ids = ["sg-045dd2b1a4b45570e"]
  #vpc_security_group_ids = ["sg-07164b6b4b39fde6a"]
  user_data              = "${data.template_file.aws_userdata.rendered}"
  tags = {
     Name = "test-cwlogs"
  }
}

data "template_file" "aws_userdata" {
  template = "${file("${path.module}/userdata.sh.tpl")}"
  vars {
    log_files = "/var/log/messages"
    #instance_id   = "${aws_instance.web.instance_id}"
    instance_id   = "InstanceID"
    log_group_name    = "/jh/test/cwlogs/02"
  }  
}
