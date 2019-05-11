# ----------------------------------------------------------------------------
# Launch Configuration variables
# ----------------------------------------------------------------------------
variable "ami_prefix" {
  type = "string"
}

variable "app_vpc_id" {
  type = "string"
}

variable "app_instance_type" {
  type = "string"
}

# ----------------------------------------------------------------------------
# Auto Scaling Group variables
# ----------------------------------------------------------------------------
variable "app_min_size" {
  type = "string"
}

variable "app_max_size" {
  type = "string"
}

variable "app_des_size" {
  type = "string"
}

variable "ec2_key_pair" {
  type = "string"
}

# ----------------------------------------------------------------------------
# Data
# ----------------------------------------------------------------------------

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
