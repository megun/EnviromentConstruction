###############################################################################
### ACM
###############################################################################
resource "aws_acm_certificate" "common" {
  domain_name = "megunlabo.net"
  subject_alternative_names  = ["*.megunlabo.net"]
  validation_method = "DNS"
  tags {
    Environment = "common"
  }
}

data "aws_route53_zone" "zone" {
  name = "megunlabo.net."
  private_zone = false
}

resource "aws_route53_record" "cert_validation" {
  name = "${aws_acm_certificate.common.domain_validation_options.0.resource_record_name}"
  type = "${aws_acm_certificate.common.domain_validation_options.0.resource_record_type}"
  zone_id = "${data.aws_route53_zone.zone.id}"
  records = ["${aws_acm_certificate.common.domain_validation_options.0.resource_record_value}"]
  ttl = 60
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn = "${aws_acm_certificate.common.arn}"
  validation_record_fqdns = [
    "${aws_route53_record.cert_validation.fqdn}"
  ]
}
