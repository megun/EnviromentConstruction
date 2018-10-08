###############################################################################
### variable vpc
###############################################################################
variable "vpc" {
  type = "map"
  default = {
    # default
    default.cidr = "10.0.0.0/16"
    default.az = "ap-northeast-1a,ap-northeast-1c,ap-northeast-1d"
    default.public_subnets = "10.0.0.0/24,10.0.1.0/24,10.0.2.0/24"
    default.private_subnets = "10.0.10.0/24,10.0.11.0/24,10.0.12.0/24"

    # dev
    dev.cidr = "10.0.0.0/16"
    default.az = "ap-northeast-1a,ap-northeast-1c,ap-northeast-1d"
    default.public_subnets = "10.0.0.0/24,10.0.1.0/24,10.0.2.0/24"
    default.private_subnets = "10.0.10.0/24,10.0.11.0/24,10.0.12.0/24"

    # prd
    prd.cidr = "10.10.0.0/16"
    prd.az = "ap-northeast-1a,ap-northeast-1c,ap-northeast-1d"
    prd.public_subnets = "10.10.0.0/24,10.10.1.0/24,10.10.2.0/24"
    prd.private_subnets = "10.10.10.0/24,10.10.11.0/24,10.10.12.0/24"
  }
}
