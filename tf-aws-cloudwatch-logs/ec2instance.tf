provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.amazon-linux-2.id}"
  instance_type = "t2.micro"
  subnet_id = "${data.aws_subnet.selected.id}"
  iam_instance_profile ="${aws_iam_instance_profile.jh05-ec2-cw-role.name}"
  key_name = "jh-us-key"
  tags = {
    Name = "test-cwlogs"
  }
}

data "template_file" "aws_userdata" {
  template = "${file("${path.module}/userdata.sh.tpl")}"
}
