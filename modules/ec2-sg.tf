resource "aws_security_group" "sg_lb" {
  name        = "sg_app"
  description = "Allow all inbound traffic"
  vpc_id      = var.lb_vpc_id

  tags = {
    Name = "sg-application"
  }
}

resource "aws_security_group_rule" "sg_lb_egress" {
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_lb.id
}

resource "aws_security_group_rule" "sg_lb_ingress_http" {
  security_group_id = aws_security_group.sg_lb.id
  type              = "ingress"
  from_port         = "80"
  to_port           = "80"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "sg_lb_ingress_ssh" {
  security_group_id = aws_security_group.sg_lb.id
  type              = "ingress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "tcp"
  cidr_blocks       = var.lb_sg_allow
}

