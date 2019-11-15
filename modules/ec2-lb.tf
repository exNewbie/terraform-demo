resource "aws_lb" "auto_scaling" {
  name = local.lb_name

  internal = "false"

  security_groups = [aws_security_group.sg_lb.id]
  subnets         = data.aws_subnet_ids.subnets.ids

  tags = local.lb_tags

  load_balancer_type         = "application"
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "target-group" {
  name_prefix = "${local.lb_tg_name}-"

  port     = 80
  protocol = "HTTP"
  vpc_id   = var.lb_vpc_id

  health_check {
    port     = 80
    protocol = "HTTP"
    matcher  = "200"
  }

  stickiness {
    type            = "lb_cookie"
    cookie_duration = 86400
    enabled         = false
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "http" {
  depends_on = [aws_lb.auto_scaling]

  load_balancer_arn = aws_lb.auto_scaling.arn

  port     = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.target-group.id
    type             = "forward"
  }
}

