data "aws_ami" "amazon-linux-2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

###############################################################################
### ec2 instance ssh
###############################################################################
resource "aws_instance" "ssh" {
  count = "${lookup(var.ec2-ssh, "${terraform.workspace}.cnt", var.ec2-ssh["default.cnt"])}"
  ami           = "${data.aws_ami.amazon-linux-2.id}"
  instance_type = "${lookup(var.ec2-ssh, "${terraform.workspace}.type", var.ec2-ssh["default.type"])}"
  vpc_security_group_ids = ["${data.terraform_remote_state.sg.security_group_common}"]
  subnet_id = "${data.terraform_remote_state.vpc.public_subnets[count.index % length(data.terraform_remote_state.vpc.public_subnets)]}"
  user_data = "${file("files/userdata.sh")}"
  key_name = "${lookup(var.ec2-ssh, "${terraform.workspace}.key", var.ec2-ssh["default.key"])}"

  iam_instance_profile  = "readonly_role"

  root_block_device = {
    volume_type = "gp2"
    volume_size = "${lookup(var.ec2-ssh, "${terraform.workspace}.root_volsize", var.ec2-ssh["default.root_volsize"])}"
  }

  tags {
    Name = "${terraform.workspace}-ssh-${format("%02d", count.index + 1)}"
    Enviroment = "${terraform.workspace}"
    Role = "ssh"
  }
}

resource "aws_eip" "ec2_ssh" {
  count = "${lookup(var.ec2-ssh, "${terraform.workspace}.eip", var.ec2-ssh["default.eip"]) ? lookup(var.ec2-ssh, "${terraform.workspace}.cnt", var.ec2-ssh["default.cnt"]) : 0}"
  vpc      = true
  instance = "${element(aws_instance.ssh.*.id,count.index)}"
}

###############################################################################
### ec2 instance web
###############################################################################
resource "aws_instance" "web" {
  count = "${lookup(var.ec2-web, "${terraform.workspace}.cnt", var.ec2-web["default.cnt"])}"

  ami           = "${data.aws_ami.amazon-linux-2.id}"
  instance_type = "${lookup(var.ec2-web, "${terraform.workspace}.type", var.ec2-web["default.type"])}"
  vpc_security_group_ids = ["${data.terraform_remote_state.sg.security_group_web}"]
  subnet_id = "${data.terraform_remote_state.vpc.public_subnets[count.index % length(data.terraform_remote_state.vpc.public_subnets)]}"
  user_data = "${file("files/userdata.sh")}"
  key_name = "${lookup(var.ec2-ssh, "${terraform.workspace}.key", var.ec2-ssh["default.key"])}"

  iam_instance_profile  = "web-instance"

  root_block_device = {
    volume_type = "gp2"
    volume_size = "${lookup(var.ec2-web, "${terraform.workspace}.root_volsize", var.ec2-web["default.root_volsize"])}"
  }

  ebs_block_device = {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = "${lookup(var.ec2-web, "${terraform.workspace}.add_volsize", var.ec2-web["default.add_volsize"])}"
  }

  tags {
    Name = "${terraform.workspace}-web-${format("%02d", count.index + 1)}"
    Enviroment = "${terraform.workspace}"
    Role = "web"
  }
}

resource "aws_eip" "ec2_web" {
  count = "${lookup(var.ec2-web, "${terraform.workspace}.eip", var.ec2-web["default.eip"]) ? lookup(var.ec2-web, "${terraform.workspace}.cnt", var.ec2-web["default.cnt"]) : 0}"
  vpc      = true
  instance = "${element(aws_instance.web.*.id,count.index)}"
}
