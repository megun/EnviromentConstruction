data "aws_vpc" "main" {
  tags = {
    Name = "${terraform.workspace}-vpc"
  }
}

###############################################################################
### common security group
###############################################################################
resource "aws_security_group" "common" {
  name        = "${terraform.workspace}-common"
  description = "Security group for ${terraform.workspace}-common"
  vpc_id      = "${data.aws_vpc.main.id}"

  tags = {
    Name = "${terraform.workspace}-common"
  }
}

module "aws_security_group_rule_common" {
  source = "../module/sg"

  ingress_service = ["tcp_22_22", "icmp_-1_-1"]    # "protocol_from-port_to-port"
  ingress_ips     = ["${var.allow_ip_01}", "${var.allow_ip_02}", "${var.allow_ip_03}"]
  ingress_sgids     = ["${aws_security_group.common.id}", "${aws_security_group.web.id}"]
  ingress_sgids_count = 2

  egress_service = ["-1_0_0"]    # "protocol_from-port_to-port"
  egress_ips      = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.common.id}"
}

###############################################################################
### web security group
###############################################################################
resource "aws_security_group" "web" {
  name        = "${terraform.workspace}-web"
  description = "Security group for ${terraform.workspace}-web"
  vpc_id      = "${data.aws_vpc.main.id}"

  tags = {
    Name = "${terraform.workspace}-web"
  }
}

module "aws_security_group_rule_web" {
  source = "../module/sg"

  ingress_service = ["tcp_80_80"]    # "protocol_from-port_to-port"
  ingress_sgids = ["${aws_security_group.alb-web.id}"]
  ingress_sgids_count = 1

  egress_service = ["-1_0_0"]    # "protocol_from-port_to-port"
  egress_ips      = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.web.id}"
}

module "aws_security_group_rule_ssh_for_common" {
  source = "../module/sg"

  ingress_service = ["tcp_22_22"]    # "protocol_from-port_to-port"
  ingress_sgids = ["${aws_security_group.common.id}"]
  ingress_sgids_count = 1

  security_group_id = "${aws_security_group.web.id}"
}

###############################################################################
### db security group
###############################################################################
resource "aws_security_group" "db" {
  name        = "${terraform.workspace}-db"
  description = "Security group for ${terraform.workspace}-db"
  vpc_id      = "${data.aws_vpc.main.id}"

  tags = {
    Name = "${terraform.workspace}-db"
  }
}

module "aws_security_group_rule_db" {
  source = "../module/sg"

  ingress_service = ["tcp_3306_3306"]    # "protocol_from-port_to-port"
  ingress_sgids = ["${aws_security_group.web.id}"]
  ingress_sgids_count = 1

  egress_service = ["tcp_3306_3306"]    # "protocol_from-port_to-port"
  egress_sgids = ["${aws_security_group.web.id}"]
  egress_sgids_count = 1

  security_group_id = "${aws_security_group.db.id}"
}

###############################################################################
### loadbalancer security group
###############################################################################
resource "aws_security_group" "alb-web" {
  name        = "${terraform.workspace}-alb-web"
  description = "Security group for ${terraform.workspace}-alb-web"
  vpc_id      = "${data.aws_vpc.main.id}"

  tags = {
    Name = "${terraform.workspace}-alb-web"
  }
}

module "aws_security_group_rule_alb-web" {
  source = "../module/sg"

  ingress_service = ["tcp_443_443"]    # "protocol_from-port_to-port"
  ingress_ips     = ["0.0.0.0/0"]

  egress_service = ["-1_0_0"]    # "protocol_from-port_to-port"
  egress_ips      = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.alb-web.id}"
}
