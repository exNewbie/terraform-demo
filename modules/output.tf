output "lb_dns_name" {
  value = "${aws_lb.auto_scaling.dns_name}"
}
