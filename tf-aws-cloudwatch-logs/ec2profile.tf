resource "aws_iam_instance_profile" "jh05-ec2-cw-role" {
  name = "jh05-ec2-cw-role"
  role = "${aws_iam_role.jh05-ec2-cw-role.name}"
}

resource "aws_iam_role" "jh05-ec2-cw-role" {
  name = "jh05-ec2-cw-role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}
resource "aws_iam_role_policy" "jh05-ec2-cw-role-policy" {
  name = "jh05-ec2-cw-role-policy"
  role = "${aws_iam_role.jh05-ec2-cw-role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:DescribeLogStreams"
        ],
        "Resource": [
            "arn:aws:logs:*:*:*"
        ]
    }
  ]
}
EOF
}