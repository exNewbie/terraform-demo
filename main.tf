provider "aws" {
  region  = "ap-southeast-2"
  profile = "default"
}

module "demo" {
  source = "./modules"

  # Launch Config variables
  ami_name      = var.ami_prefix
  instance_type = var.app_instance_type

  # Auto Scaling Group variables
  asg_min_size                     = var.app_min_size
  asg_max_size                     = var.app_max_size
  asg_desired_capacity             = var.app_des_size
  lifecycle_hook_launching_enabled = true

  # Application Load Balancer variables
  lb_vpc_id   = var.app_vpc_id
  lb_sg_allow = [join("", [trimspace(data.http.myip.body), "/32"])]
}

output "lb_dns_name" {
  value = "http://${module.demo.lb_dns_name}"
}

