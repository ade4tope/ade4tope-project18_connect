data "aws_route53_zone" "teadservices" {
  name         = "teadservices.com"
  private_zone = false
}


# create records for tooling
resource "aws_route53_record" "tooling" {
  zone_id = data.aws_route53_zone.teadservices.zone_id
  name    = "tooling.teadservices.com"
  type    = "A"

  alias {
    name                   = var.external_alb_dns_name
    zone_id                = var.external_alb_zone_id
    evaluate_target_health = true
  }
}


# create records for wordpress
resource "aws_route53_record" "wordpress" {
  zone_id = data.aws_route53_zone.teadservices.zone_id
  name    = "wordpress.teadservices.com"
  type    = "A"

  alias {
    name                   = var.external_alb_dns_name
    zone_id                = var.external_alb_zone_id
    evaluate_target_health = true
  }
}