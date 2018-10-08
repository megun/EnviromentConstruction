###############################################################################
### iam ec2 instance readonly
###############################################################################
resource "aws_iam_instance_profile" "readonly_role" {
  name = "readonly_role"
  path = "/ec2/"
  role = "${aws_iam_role.readonly_role.name}"
}

resource "aws_iam_role" "readonly_role" {
  name = "readonly_role"
  path = "/ec2/"

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

resource "aws_iam_role_policy_attachment" "readonly_role" {
  role       = "${aws_iam_role.readonly_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

###############################################################################
### iam ec2 instance web
###############################################################################
resource "aws_iam_instance_profile" "web-instance" {
  name = "web-instance"
  path = "/ec2/"
  role = "${aws_iam_role.web-instance_role.name}"
}

resource "aws_iam_role" "web-instance_role" {
  name = "${terraform.workspace}-web-instance"
  path = "/ec2/"

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

resource "aws_iam_role_policy_attachment" "web-instance_role" {
  role       = "${aws_iam_role.web-instance_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role_policy" "web-instance" {
    name = "${terraform.workspace}-web-instance"
    role       = "${aws_iam_role.web-instance_role.name}"
    policy = "${file("files/${terraform.workspace}/web-instance-policy.json")}"
}
