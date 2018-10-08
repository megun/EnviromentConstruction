variable "vpc_id" {default = ""}

variable "ec2-ssh" {
  type = "map"
  default = {
    default.cnt = 0
    default.ami = "ami-08847abae18baa040"
    default.type = "t2.micro"
    default.key = "AWS1"
    default.eip = true
    default.root_volsize = 30

    dev.cnt = 1
    dev.ami = "ami-08847abae18baa040"
    dev.type = "t2.micro"
    dev.key = "AWS1"
    dev.eip = true
    dev.root_volsize = 10

    prd.cnt = 1
    prd.ami = "ami-08847abae18baa040"
    prd.type = "t2.micro"
    prd.key = "AWS1"
    prd.eip = true
    prd.root_volsize = 30
  }
}

variable "ec2-web" {
  type = "map"
  default = {
    default.cnt = 0
    default.ami = "ami-08847abae18baa040"
    default.type = "t2.micro"
    default.key = "AWS1"
    default.eip = false
    default.root_volsize = 30
    default.add_volsize = 10

    dev.cnt = 1
    dev.ami = "ami-08847abae18baa040"
    dev.type = "t2.micro"
    dev.key = "AWS1"
    dev.eip = false
    dev.root_volsize = 30
    default.add_volsize = 10

    prd.cnt = 2
    prd.ami = "ami-08847abae18baa040"
    prd.type = "t2.micro"
    prd.key = "AWS1"
    prd.eip = false
    prd.root_volsize = 30
    default.add_volsize = 10
  }
}
