resource "aws_iam_role" "ec2_instance" {
  name = "demo-ec2"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ec2_instance_Lifecycle" {
  name = "ec2-instance-CloudWatchLogs"
  role = aws_iam_role.ec2_instance.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "autoscaling:CompleteLifecycleAction"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "demo-profile"
  role = aws_iam_role.ec2_instance.name
}
