resource "aws_lb" "kilo_lb" {
  name               = "kilo-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.kilo_sg.id]
  subnets           = [aws_subnet.public_subnet.id]
}

resource "aws_lb_target_group" "kilo_tg" {
  name     = "kilo-target-group"
  port     = 5001
  protocol = "HTTP"
  vpc_id   = aws_vpc.kilo_vpc.id
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.kilo_lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.kilo_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kilo_tg.arn
  }
}

resource "aws_acm_certificate" "kilo_cert" {
  domain_name       = "kilo-test.com"
  validation_method = "DNS"
}
