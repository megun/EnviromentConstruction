###############################################################################
### S3 AWS Logs Bucket
###############################################################################
data "template_file" "aws-logs-policy" {
  template = "${file("files/aws-logs-policy.json")}"

  vars {
    bucket_name = "${terraform.workspace}-aws-megun-systems"
    aws_elb_service_account = "${data.aws_elb_service_account.main.arn}"
  }
}

data "aws_elb_service_account" "main" {}

resource "aws_s3_bucket" "aws-logs" {
  bucket        = "${terraform.workspace}-aws-megun-systems"
  acl           = "private"

  policy = "${data.template_file.aws-logs-policy.rendered}"

  force_destroy = true

  lifecycle_rule {
    id      = "log"
    enabled = true

#    prefix  = "log"
    tags {
      "rule"      = "log"
      "autoclean" = "true"
    }

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }
  }
}
