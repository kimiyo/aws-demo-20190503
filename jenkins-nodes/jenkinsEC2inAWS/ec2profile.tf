resource "aws_iam_instance_profile" "jh-jenkins-master" {
  name = "jh-jenkins-master"
  role = "${aws_iam_role.jh-jenkins-master.name}"
}

resource "aws_iam_role" "jh-jenkins-master" {
  name = "jh-jenkins-master"
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
resource "aws_iam_role_policy" "jh-jenkins-master-policy" {
  name = "jh-jenkins-master-policy"
  role = "${aws_iam_role.jh-jenkins-master.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Sid": "accesstocwloggroup",
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
    },
    {
            "Sid": "s3listbucket",
            "Effect": "Allow",
            "Action": [
                "s3:ListAllMyBuckets",
                "s3:HeadBucket"
            ],
            "Resource": "arn:aws:s3:::jh-jenkins-configuration-20190609"
     },
     {
            "Sid": "s3putobjects",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::jh-jenkins-configuration-20190609/*",
                "arn:aws:s3:::jh-jenkins-configuration-20190609"
            ]
     }
  ]
}
EOF
}