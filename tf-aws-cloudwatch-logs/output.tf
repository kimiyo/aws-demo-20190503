output "public_ip" {
  value = "${aws_instance.web.public_ip}"
}
output "public_dns" {
  value = "${aws_instance.web.public_dns}"
}
output "remote_cmd" {
  value = "ssh -i \"${aws_instance.web.key_name}.pem\" ec2-user@${aws_instance.web.public_dns}"
}
output "ami_cmd" {
  value = "${data.aws_ami.amazon-linux-2.id}"
}
