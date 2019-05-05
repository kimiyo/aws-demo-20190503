
locals {
  vpcName="default"
  subnetName="default-1a"
}

data "aws_ami" "amazon-linux-2" {
 most_recent = true
 owners = ["amazon"]
 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }
}
data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${local.subnetName}"]
  }
}
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${local.vpcName}"]
  }
}
