###############################################################################
### alb
###############################################################################
resource "aws_lb" "web" {
  name               = "${terraform.workspace}-alb-web"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${data.terraform_remote_state.sg.security_group_alb-web}"]
  subnets            = ["${data.terraform_remote_state.vpc.public_subnets}"]

  enable_deletion_protection = false

  access_logs {
    bucket  = "${data.terraform_remote_state.Storage.awslogs_bucket_name}"
    prefix  = "lb-logs/${terraform.workspace}-alb-web"
    enabled = true
  }

  tags {
    Name = "${terraform.workspace}-alb-web"
    Environment = "${terraform.workspace}"
  }
}

data "aws_acm_certificate" "common" {
  domain   = "megunlabo.net"
  statuses = ["ISSUED"]
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = "${aws_lb.web.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = "${data.aws_acm_certificate.common.arn}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.web.arn}"
  }
}

resource "aws_lb_target_group" "web" {
  name     = "${terraform.workspace}-tg-web"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${data.terraform_remote_state.vpc.vpc_id}"
}

resource "aws_lb_target_group_attachment" "web" {
  target_group_arn = "${aws_lb_target_group.web.arn}"
  target_id        = "${element(aws_instance.web.*.id,count.index)}"
  port             = 80
}
