
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${local.vpcName}"]
  }
}

data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${local.subnetName}"]
  }
}
#amzn2-ami-hvm-2.0.20190508-x86_64-gp2  (ami-08ab3f7e72215fe91)
#amzn2-ami-hvm-2.0.20190313-x86_64-gp2-SQL_2017_Express-2019.04.02 (ami-08088b9085639b001)
data "aws_ami" "amazon-linux-2" {
 most_recent = true
 

    filter {
        name   = "owner-alias"
        values = ["amazon"]
    }

    owners = ["amazon"]

    filter {
        name   = "name"
        values = ["amzn2-ami-hvm*"]
    }
    filter {
        name = "state"
        values = ["available"]
    }
    # filter {
    #   name   = "platform"
    #   values = ["Amazon Linux"]
    # }   
}
data "aws_security_group" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${local.sgName}"]
  }
}
