output "awslogs_bucket_name" {
  description = "aws logs bucket name"
  value = "${aws_s3_bucket.aws-logs.id}"
}
