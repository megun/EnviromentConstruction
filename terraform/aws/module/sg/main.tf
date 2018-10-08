# nested loop reference
# https://qiita.com/raki/items/ddb58b9b71f1e8d412a5

locals {
  counter = {
    ingress_service  = "${length(var.ingress_service)}"
    ingress_sgids_count = "${var.ingress_sgids_count}"
    egress_service  = "${length(var.egress_service)}"
    egress_sgids_count = "${var.egress_sgids_count}"
  }
}

resource "aws_security_group_rule" "ingress_cidr" {
  count = "${length(var.ingress_ips) == 0 ? 0 : length(var.ingress_service)}"

  type            = "ingress"
  protocol        = "${element(split("_", var.ingress_service[count.index]), 0)}"
  from_port       = "${element(split("_", var.ingress_service[count.index]), 1)}"
  to_port         = "${element(split("_", var.ingress_service[count.index]), 2)}"
  cidr_blocks     = "${var.ingress_ips}"

  security_group_id = "${var.security_group_id}"
}

resource "aws_security_group_rule" "ingress_sgid" {
  count = "${local.counter["ingress_service"] * local.counter["ingress_sgids_count"]}"

  type            = "ingress"
  protocol        = "${element(split("_", var.ingress_service[count.index % local.counter["ingress_service"]]), 0)}"
  from_port       = "${element(split("_", var.ingress_service[count.index % local.counter["ingress_service"]]), 1)}"
  to_port         = "${element(split("_", var.ingress_service[count.index % local.counter["ingress_service"]]), 2)}"
  source_security_group_id     = "${var.ingress_sgids[count.index / local.counter["ingress_sgids_count"]]}"

  security_group_id = "${var.security_group_id}"
}

resource "aws_security_group_rule" "egress_cidr" {
  count = "${length(var.egress_ips) == 0 ? 0 : length(var.egress_service)}"

  type            = "egress"
  protocol = "${element(split("_", var.egress_service[count.index]), 0)}"
  from_port = "${element(split("_", var.egress_service[count.index]), 1)}"
  to_port = "${element(split("_", var.egress_service[count.index]), 2)}"
  cidr_blocks     = "${var.egress_ips}"

  security_group_id = "${var.security_group_id}"
}

resource "aws_security_group_rule" "egress_sgid" {
  count = "${local.counter["egress_service"] * local.counter["egress_sgids_count"]}"

  type            = "egress"
  protocol = "${element(split("_", var.egress_service[count.index % local.counter["egress_service"]]), 0)}"
  from_port = "${element(split("_", var.egress_service[count.index % local.counter["egress_service"]]), 1)}"
  to_port = "${element(split("_", var.egress_service[count.index % local.counter["egress_service"]]), 2)}"

  source_security_group_id     = "${var.egress_sgids[count.index / local.counter["egress_sgids_count"]]}"

  security_group_id = "${var.security_group_id}"
}
