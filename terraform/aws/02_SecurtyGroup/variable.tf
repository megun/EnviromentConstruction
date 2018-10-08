###############################################################################
### variable security group
###############################################################################
variable "allow_ip_01" {
  default = ["1.1.1.1/32", "2.2.2.2/32"]
}

variable "allow_ip_02" {
  default = ["3.3.3.3/32"]
}

variable "allow_ip_03" {
  default = ["4.4.4.4/32", "5.5.5.5/32", "6.6.6.6/32"]
}