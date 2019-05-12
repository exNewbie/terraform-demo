provider "aws" {
  region = "ap-southeast-2"
}

module "ctm" {
  source = "./modules"

  # Launch Config variables
  ami_name      = "${var.ami_prefix}"
  instance_type = "${var.app_instance_type}"

  # Auto Scaling Group variables
  asg_min_size         = "${var.app_min_size}"
  asg_max_size         = "${var.app_max_size}"
  asg_desired_capacity = "${var.app_des_size}"
  ec2_key_pair         = "${var.ec2_key_pair}"

  # Application Load Balancer variables
  lb_vpc_id   = "${var.app_vpc_id}"
  lb_sg_allow = ["${join("", list(trimspace(data.http.myip.body), "/32"))}"]
}

output "lb_dns_name" {
  value = "http://${module.ctm.lb_dns_name}"
}
