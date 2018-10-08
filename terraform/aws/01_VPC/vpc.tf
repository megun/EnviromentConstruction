###############################################################################
### create vpc
###############################################################################
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${terraform.workspace}-vpc"
  cidr = "${lookup(var.vpc, "${terraform.workspace}.cidr", var.vpc["default.cidr"])}"
  azs             = ["${split(",", lookup(var.vpc, "${terraform.workspace}.az", var.vpc["default.az"]))}"]
  public_subnets  = ["${split(",", lookup(var.vpc, "${terraform.workspace}.public_subnets", var.vpc["default.public_subnets"]))}"]
  private_subnets = ["${split(",", lookup(var.vpc, "${terraform.workspace}.private_subnets", var.vpc["default.private_subnets"]))}"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "${terraform.workspace}"
  }
}
