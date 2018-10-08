output "security_group_common" {
  description = "The ID of the security group"
  value = "${aws_security_group.common.id}"
}

output "security_group_web" {
  description = "The ID of the security group"
  value = "${aws_security_group.web.id}"
}

output "security_group_db" {
  description = "The ID of the security group"
  value = "${aws_security_group.db.id}"
}

output "security_group_alb-web" {
  description = "The ID of the security group"
  value = "${aws_security_group.alb-web.id}"
}

output "acm-common" {
  description = "The ID of the security group"
  value = "${aws_security_group.alb-web.id}"
}
