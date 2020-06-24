resource "aws_launch_configuration" "launch_configuration" {
  name_prefix = "launch-conf-app-"

  image_id             = data.aws_ami.ami.id
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.sg_lb.id]
  key_name             = var.ec2_key_pair
  user_data            = data.template_file.start_deploy.rendered
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  depends_on = [
    aws_lb.auto_scaling,
    aws_launch_configuration.launch_configuration
  ]

  ## Change here to create new servers
  name = "asg-application"

  min_size         = var.asg_min_size
  max_size         = var.asg_max_size
  desired_capacity = var.asg_desired_capacity

  availability_zones = data.aws_availability_zones.azs.names

  launch_configuration = aws_launch_configuration.launch_configuration.name

  health_check_grace_period = 0

  force_delete = false

  vpc_zone_identifier = data.aws_subnet_ids.subnets.ids

  target_group_arns = [aws_lb_target_group.target-group.arn]

  tags = local.asg_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_lifecycle_hook" "lifecycle_hook_terminating" {
  count = var.lifecycle_hook_terminating_enabled ? 1 : 0

  name                   = "Terminating"
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
  default_result         = "CONTINUE"
  heartbeat_timeout      = var.lifecycle_hook_terminating_timeout
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
}

resource "aws_autoscaling_lifecycle_hook" "lifecycle_hook_launching" {
  count = var.lifecycle_hook_launching_enabled ? 1 : 0

  name                   = "Launching"
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
  default_result         = "CONTINUE"
  heartbeat_timeout      = var.lifecycle_hook_launching_timeout
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_LAUNCHING"
}

