resource "aws_route53_record" "demo" {
  zone_id = var.route53_zone_id
  name    = var.webapp_dnsname
  type    = "A"

  alias {
    name                   = aws_elb.nomad_client.dns_name
    zone_id                = aws_elb.nomad_client.zone_id
    evaluate_target_health = true
  }
}