resource "aws_launch_configuration" "launch_configuration" {
  name_prefix = "launch-conf-application-"

  image_id        = data.aws_ami.ami.id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.sg_lb.id]
  key_name        = var.ec2_key_pair
  user_data       = data.template_file.start_deploy.rendered

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  depends_on = [
    aws_lb.auto_scaling,
    aws_launch_configuration.launch_configuration,
  ]

  name = "asg-application"

  min_size         = var.asg_min_size
  max_size         = var.asg_max_size
  desired_capacity = var.asg_desired_capacity

  availability_zones = data.aws_availability_zones.azs.names

  launch_configuration = aws_launch_configuration.launch_configuration.name

  force_delete = false

  vpc_zone_identifier = data.aws_subnet_ids.subnets.ids

  target_group_arns = [aws_lb_target_group.target-group.arn]

  tags = local.asg_tags

  lifecycle {
    create_before_destroy = true
  }
}

