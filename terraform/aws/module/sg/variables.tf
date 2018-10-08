variable "ingress_service" {default = []}
variable "ingress_sgids" {default = []}
variable "ingress_ips" {default = []}

variable "egress_service" {default = []}
variable "egress_sgids" {default = []}
variable "egress_ips" {default = []}

variable "security_group_id" {default = ""}

variable "ingress_sgids_count" {default = 0}
variable "egress_sgids_count" {default = 0}
