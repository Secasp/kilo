resource "aws_route53_zone" "kilo_zone" {
  name = "kilo-test.com"
}

resource "aws_route53_record" "kilo_record" {
  zone_id = aws_route53_zone.kilo_zone.zone_id
  name    = "kilo-test.com"
  type    = "A"

  alias {
    name                   = aws_lb.kilo_lb.dns_name
    zone_id                = aws_lb.kilo_lb.zone_id
    evaluate_target_health = true
  }
  depends_on = [aws_lb.kilo_lb]
}
