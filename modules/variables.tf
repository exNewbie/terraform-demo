# ------------------------------------------------------------------------------
# Local variables
# ------------------------------------------------------------------------------

# Set sane defaults for metadata
locals {
  asg_tags = [
    {
      key                 = "Name"
      value               = "application"
      propagate_at_launch = true
    },
  ]

  lb_name    = "lb-application"
  lb_tg_name = "app"

  lb_tags = {
    Name = local.lb_name
  }
}

# ------------------------------------------------------------------------------
# Launch Configuration variables
# ------------------------------------------------------------------------------

# Required
variable "ami_name" {
  type        = string
  description = "Name of AMI"
}

variable "instance_type" {
  type        = string
  description = "The type of instance to be used for auto-scaling"
}

variable "ec2_key_pair" {
  type        = string
  description = "EC2 key pair to be used for instances brought up with the ASG."
  default     = ""
}

# ------------------------------------------------------------------------------
# Auto Scaling Group variables
# ------------------------------------------------------------------------------

# Required
variable "asg_desired_capacity" {
  type        = string
  description = "Desired number of instances allowed in the auto-scaling group."
}

variable "asg_min_size" {
  type        = string
  description = "Minimum number of instances allowed in the auto-scaling group."
}

variable "asg_max_size" {
  type        = string
  description = "Maximum number of instances allowed in the auto-scaling group."
}

# ------------------------------------------------------------------------------
# Load Balancer variables
# ------------------------------------------------------------------------------

variable "lb_vpc_id" {
  type        = string
  description = "VPC ID for the load balancer to use."
}

variable "lb_sg_allow" {
  type        = list(string)
  description = "List of IPs that allows to SSH access instance(s)"
}

# ------------------------------------------------------------------------------
# Data
# ------------------------------------------------------------------------------

data "aws_availability_zones" "azs" {
}

data "aws_subnet_ids" "subnets" {
  vpc_id = var.lb_vpc_id
}

data "aws_elb_service_account" "main" {
}

data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon", "aws-marketplace"]

  filter {
    name   = "name"
    values = [var.ami_name]
  }
}

data "template_file" "start_deploy" {
  template = file("${path.module}/scripts/start-deploy.tpl")
}

