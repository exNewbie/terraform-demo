In this sample, a new stack including
- 2 EC2 instaces with user data script
- A launch configuration
- A target group
- An auto scaling group
- A Load balancer serving HTTP traffic at port 80
- Security groups for Load Balancer and EC2 instance

**Terraform** is used to managed AWS resources. It is able to create, modify and remove AWS resources. 


## Prerequisites

### Install Terraform

 - If your workstation is MacOS,
```
    unzip terraform_0.12.15_darwin_amd64.zip
```
 - If your workstation is Linux,
 ```
    unzip terraform_0.12.15_linux_amd64.zip
```


### Modify ***terraform.tfvars*** and fill in your values

- ***app_vpc_id***: VPC ID. This sample is designed for *default* VPC only.
- ***ec2_key_pair***: Key pair name which will be used to SSH to EC2 instance(s)

Additionally, if you want to run only 1 EC2 instance, you will need to modify this variable
- ***app_des_size = 1***


### Initialise Terraform module and download its plugins
After finishing those steps above, use this command to prepare for Terraform to deploy a stack
```
./terraform init
```

Expected output
```
Upgrading modules...
- module.ctm
  Updating source "./modules"

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "http" (1.1.1)...
- Downloading plugin for provider "aws" (2.10.0)...
- Downloading plugin for provider "template" (2.1.2)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 2.10"
* provider.http: version = "~> 1.1"
* provider.template: version = "~> 2.1"

Terraform has been successfully initialized!
```

## Deploy stack
Terraform will spin up a new stack.
```
./terraform apply -auto-approve
```

Expected output
```
data.template_file.start_deploy: Refreshing state...
data.http.myip: Refreshing state...
data.aws_ami.ami: Refreshing state...
data.aws_subnet_ids.subnets: Refreshing state...
data.aws_elb_service_account.main: Refreshing state...
data.aws_availability_zones.azs: Refreshing state...
module.ctm.aws_lb_target_group.target-group: Creating...
  arn:                                "" => "<computed>"
  arn_suffix:                         "" => "<computed>"
  deregistration_delay:               "" => "300"
  health_check.#:                     "" => "1"
  health_check.0.enabled:             "" => "true"
  health_check.0.healthy_threshold:   "" => "3"
  health_check.0.interval:            "" => "30"
  health_check.0.matcher:             "" => "200"
  health_check.0.path:                "" => "<computed>"
  health_check.0.port:                "" => "80"
  health_check.0.protocol:            "" => "HTTP"
  health_check.0.timeout:             "" => "<computed>"
  health_check.0.unhealthy_threshold: "" => "3"
  lambda_multi_value_headers_enabled: "" => "false"
  name:                               "" => "<computed>"
  name_prefix:                        "" => "app-"
  port:                               "" => "80"
  protocol:                           "" => "HTTP"
  proxy_protocol_v2:                  "" => "false"
  slow_start:                         "" => "0"
  stickiness.#:                       "" => "1"
  stickiness.0.cookie_duration:       "" => "86400"
  stickiness.0.enabled:               "" => "false"
  stickiness.0.type:                  "" => "lb_cookie"
  target_type:                        "" => "instance"
  vpc_id:                             "" => "vpc-7f364f1b"
module.ctm.aws_security_group.sg_lb: Creating...
  arn:                    "" => "<computed>"
  description:            "" => "Allow all inbound traffic"
  egress.#:               "" => "<computed>"
  ingress.#:              "" => "<computed>"
  name:                   "" => "sg_app"
  owner_id:               "" => "<computed>"
  revoke_rules_on_delete: "" => "false"
  tags.%:                 "" => "1"
  tags.Name:              "" => "sg-app"
  vpc_id:                 "" => "vpc-7f364f1b"
module.ctm.aws_lb_target_group.target-group: Creation complete after 2s (ID: arn:aws:elasticloadbalancing:ap-southea...511160653395600000001/19b1ae34926b72aa)
module.ctm.aws_security_group.sg_lb: Creation complete after 3s (ID: sg-0f77ab062e6a8d7e2)
module.ctm.aws_security_group_rule.sg_lb_egress: Creating...
  cidr_blocks.#:            "" => "1"
  cidr_blocks.0:            "" => "0.0.0.0/0"
  from_port:                "" => "0"
  protocol:                 "" => "-1"
  security_group_id:        "" => "sg-0f77ab062e6a8d7e2"
  self:                     "" => "false"
  source_security_group_id: "" => "<computed>"
  to_port:                  "" => "0"
  type:                     "" => "egress"
module.ctm.aws_security_group_rule.sg_lb_ingress_http: Creating...
  cidr_blocks.#:            "" => "1"
  cidr_blocks.0:            "" => "0.0.0.0/0"
  from_port:                "" => "80"
  protocol:                 "" => "tcp"
  security_group_id:        "" => "sg-0f77ab062e6a8d7e2"
  self:                     "" => "false"
  source_security_group_id: "" => "<computed>"
  to_port:                  "" => "80"
  type:                     "" => "ingress"
module.ctm.aws_security_group_rule.sg_lb_ingress_ssh: Creating...
  cidr_blocks.#:            "" => "1"
  cidr_blocks.0:            "" => "49.182.3.134/32"
  from_port:                "" => "22"
  protocol:                 "" => "tcp"
  security_group_id:        "" => "sg-0f77ab062e6a8d7e2"
  self:                     "" => "false"
  source_security_group_id: "" => "<computed>"
  to_port:                  "" => "22"
  type:                     "" => "ingress"
module.ctm.aws_launch_configuration.launch_configuration: Creating...
  associate_public_ip_address: "" => "false"
  ebs_block_device.#:          "" => "<computed>"
  ebs_optimized:               "" => "<computed>"
  enable_monitoring:           "" => "true"
  image_id:                    "" => "ami-04481c741a0311bbb"
  instance_type:               "" => "t3.nano"
  key_name:                    "" => "aws-workstation"
  name:                        "" => "<computed>"
  name_prefix:                 "" => "launch-conf-application-"
  root_block_device.#:         "" => "<computed>"
  security_groups.#:           "" => "1"
  security_groups.877529311:   "" => "sg-0f77ab062e6a8d7e2"
  user_data:                   "" => "96697105a3a3501e90b6f26690f14054121af5bf"
module.ctm.aws_lb.auto_scaling: Creating...
  arn:                        "" => "<computed>"
  arn_suffix:                 "" => "<computed>"
  dns_name:                   "" => "<computed>"
  enable_deletion_protection: "" => "false"
  enable_http2:               "" => "true"
  idle_timeout:               "" => "60"
  internal:                   "" => "false"
  ip_address_type:            "" => "<computed>"
  load_balancer_type:         "" => "application"
  name:                       "" => "lb-application"
  security_groups.#:          "" => "1"
  security_groups.877529311:  "" => "sg-0f77ab062e6a8d7e2"
  subnet_mapping.#:           "" => "<computed>"
  subnets.#:                  "" => "3"
  subnets.2121174501:         "" => "subnet-7f9cab09"
  subnets.3563414530:         "" => "subnet-9f98f2c6"
  subnets.69352571:           "" => "subnet-29d0d14d"
  tags.%:                     "" => "1"
  tags.Name:                  "" => "lb-application"
  vpc_id:                     "" => "<computed>"
  zone_id:                    "" => "<computed>"
module.ctm.aws_security_group_rule.sg_lb_egress: Creation complete after 1s (ID: sgrule-2217466521)
module.ctm.aws_launch_configuration.launch_configuration: Creation complete after 1s (ID: launch-conf-application-20190511160656498700000002)
module.ctm.aws_security_group_rule.sg_lb_ingress_http: Creation complete after 2s (ID: sgrule-3987887181)
module.ctm.aws_security_group_rule.sg_lb_ingress_ssh: Creation complete after 4s (ID: sgrule-2647260647)
module.ctm.aws_lb.auto_scaling: Still creating... (10s elapsed)
module.ctm.aws_lb.auto_scaling: Still creating... (20s elapsed)
module.ctm.aws_lb.auto_scaling: Still creating... (30s elapsed)
module.ctm.aws_lb.auto_scaling: Still creating... (40s elapsed)
module.ctm.aws_lb.auto_scaling: Still creating... (50s elapsed)
module.ctm.aws_lb.auto_scaling: Still creating... (1m0s elapsed)
module.ctm.aws_lb.auto_scaling: Still creating... (1m10s elapsed)
module.ctm.aws_lb.auto_scaling: Still creating... (1m20s elapsed)
module.ctm.aws_lb.auto_scaling: Still creating... (1m30s elapsed)
module.ctm.aws_lb.auto_scaling: Still creating... (1m40s elapsed)
module.ctm.aws_lb.auto_scaling: Still creating... (1m50s elapsed)
module.ctm.aws_lb.auto_scaling: Still creating... (2m0s elapsed)
module.ctm.aws_lb.auto_scaling: Still creating... (2m10s elapsed)
module.ctm.aws_lb.auto_scaling: Still creating... (2m20s elapsed)
module.ctm.aws_lb.auto_scaling: Still creating... (2m30s elapsed)
module.ctm.aws_lb.auto_scaling: Still creating... (2m40s elapsed)
module.ctm.aws_lb.auto_scaling: Still creating... (2m50s elapsed)
module.ctm.aws_lb.auto_scaling: Still creating... (3m0s elapsed)
module.ctm.aws_lb.auto_scaling: Creation complete after 3m9s (ID: arn:aws:elasticloadbalancing:ap-southea...er/app/lb-application/381e7108a00dd7e0)
module.ctm.aws_lb_listener.http: Creating...
  arn:                               "" => "<computed>"
  default_action.#:                  "" => "1"
  default_action.0.order:            "" => "<computed>"
  default_action.0.target_group_arn: "" => "arn:aws:elasticloadbalancing:ap-southeast-2:324777369088:targetgroup/app-20190511160653395600000001/19b1ae34926b72aa"
  default_action.0.type:             "" => "forward"
  load_balancer_arn:                 "" => "arn:aws:elasticloadbalancing:ap-southeast-2:324777369088:loadbalancer/app/lb-application/381e7108a00dd7e0"
  port:                              "" => "80"
  protocol:                          "" => "HTTP"
  ssl_policy:                        "" => "<computed>"
module.ctm.aws_autoscaling_group.autoscaling_group: Creating...
  arn:                            "" => "<computed>"
  default_cooldown:               "" => "<computed>"
  desired_capacity:               "" => "2"
  force_delete:                   "" => "false"
  health_check_grace_period:      "" => "300"
  health_check_type:              "" => "<computed>"
  launch_configuration:           "" => "launch-conf-application-20190511160656498700000002"
  load_balancers.#:               "" => "<computed>"
  max_size:                       "" => "2"
  metrics_granularity:            "" => "1Minute"
  min_size:                       "" => "1"
  name:                           "" => "asg-application"
  protect_from_scale_in:          "" => "false"
  service_linked_role_arn:        "" => "<computed>"
  tags.#:                         "" => "1"
  tags.0.%:                       "" => "3"
  tags.0.key:                     "" => "Name"
  tags.0.propagate_at_launch:     "" => "1"
  tags.0.value:                   "" => "application"
  target_group_arns.#:            "" => "1"
  target_group_arns.3611452258:   "" => "arn:aws:elasticloadbalancing:ap-southeast-2:324777369088:targetgroup/app-20190511160653395600000001/19b1ae34926b72aa"
  vpc_zone_identifier.#:          "" => "3"
  vpc_zone_identifier.2121174501: "" => "subnet-7f9cab09"
  vpc_zone_identifier.3563414530: "" => "subnet-9f98f2c6"
  vpc_zone_identifier.69352571:   "" => "subnet-29d0d14d"
  wait_for_capacity_timeout:      "" => "10m"
module.ctm.aws_lb_listener.http: Creation complete after 1s (ID: arn:aws:elasticloadbalancing:ap-southea...tion/381e7108a00dd7e0/f88c0b605f0b9418)
module.ctm.aws_autoscaling_group.autoscaling_group: Still creating... (10s elapsed)
module.ctm.aws_autoscaling_group.autoscaling_group: Still creating... (20s elapsed)
module.ctm.aws_autoscaling_group.autoscaling_group: Still creating... (30s elapsed)
module.ctm.aws_autoscaling_group.autoscaling_group: Still creating... (40s elapsed)
module.ctm.aws_autoscaling_group.autoscaling_group: Creation complete after 43s (ID: asg-application)

Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

Outputs:

lb_dns_name = lb-application-1221915767.ap-southeast-2.elb.amazonaws.com
```

The last line is ***the Load Balancer endpoint***. When it is browsed, it will show an instance ID of one of EC2 instances.


## Remove the stack
Terraform will remove sources it created earlier.
```
./terraform destroy -auto-approve
```

Expected output
```
data.http.myip: Refreshing state...
data.template_file.start_deploy: Refreshing state...
aws_lb_target_group.target-group: Refreshing state... (ID: arn:aws:elasticloadbalancing:ap-southea...511160653395600000001/19b1ae34926b72aa)
aws_security_group.sg_lb: Refreshing state... (ID: sg-0f77ab062e6a8d7e2)
data.aws_elb_service_account.main: Refreshing state...
data.aws_availability_zones.azs: Refreshing state...
data.aws_subnet_ids.subnets: Refreshing state...
data.aws_ami.ami: Refreshing state...
aws_security_group_rule.sg_lb_egress: Refreshing state... (ID: sgrule-2217466521)
aws_security_group_rule.sg_lb_ingress_ssh: Refreshing state... (ID: sgrule-2647260647)
aws_security_group_rule.sg_lb_ingress_http: Refreshing state... (ID: sgrule-3987887181)
aws_lb.auto_scaling: Refreshing state... (ID: arn:aws:elasticloadbalancing:ap-southea...er/app/lb-application/381e7108a00dd7e0)
aws_launch_configuration.launch_configuration: Refreshing state... (ID: launch-conf-application-20190511160656498700000002)
aws_lb_listener.http: Refreshing state... (ID: arn:aws:elasticloadbalancing:ap-southea...tion/381e7108a00dd7e0/f88c0b605f0b9418)
aws_autoscaling_group.autoscaling_group: Refreshing state... (ID: asg-application)
module.ctm.aws_security_group_rule.sg_lb_ingress_http: Destroying... (ID: sgrule-3987887181)
module.ctm.aws_lb_listener.http: Destroying... (ID: arn:aws:elasticloadbalancing:ap-southea...tion/381e7108a00dd7e0/f88c0b605f0b9418)
module.ctm.aws_security_group_rule.sg_lb_ingress_ssh: Destroying... (ID: sgrule-2647260647)
module.ctm.aws_autoscaling_group.autoscaling_group: Destroying... (ID: asg-application)
module.ctm.aws_security_group_rule.sg_lb_egress: Destroying... (ID: sgrule-2217466521)
module.ctm.aws_lb_listener.http: Destruction complete after 1s
module.ctm.aws_security_group_rule.sg_lb_ingress_http: Destruction complete after 1s
module.ctm.aws_security_group_rule.sg_lb_ingress_ssh: Destruction complete after 2s
module.ctm.aws_security_group_rule.sg_lb_egress: Destruction complete after 3s
module.ctm.aws_autoscaling_group.autoscaling_group: Still destroying... (ID: asg-application, 10s elapsed)
module.ctm.aws_autoscaling_group.autoscaling_group: Still destroying... (ID: asg-application, 20s elapsed)
module.ctm.aws_autoscaling_group.autoscaling_group: Still destroying... (ID: asg-application, 30s elapsed)
module.ctm.aws_autoscaling_group.autoscaling_group: Still destroying... (ID: asg-application, 40s elapsed)
module.ctm.aws_autoscaling_group.autoscaling_group: Still destroying... (ID: asg-application, 50s elapsed)
module.ctm.aws_autoscaling_group.autoscaling_group: Still destroying... (ID: asg-application, 1m0s elapsed)
module.ctm.aws_autoscaling_group.autoscaling_group: Still destroying... (ID: asg-application, 1m10s elapsed)
module.ctm.aws_autoscaling_group.autoscaling_group: Still destroying... (ID: asg-application, 1m20s elapsed)
module.ctm.aws_autoscaling_group.autoscaling_group: Still destroying... (ID: asg-application, 1m30s elapsed)
module.ctm.aws_autoscaling_group.autoscaling_group: Still destroying... (ID: asg-application, 1m40s elapsed)
module.ctm.aws_autoscaling_group.autoscaling_group: Still destroying... (ID: asg-application, 1m50s elapsed)
module.ctm.aws_autoscaling_group.autoscaling_group: Still destroying... (ID: asg-application, 2m0s elapsed)
module.ctm.aws_autoscaling_group.autoscaling_group: Still destroying... (ID: asg-application, 2m10s elapsed)
module.ctm.aws_autoscaling_group.autoscaling_group: Destruction complete after 2m11s
module.ctm.aws_launch_configuration.launch_configuration: Destroying... (ID: launch-conf-application-20190511160656498700000002)
module.ctm.aws_lb.auto_scaling: Destroying... (ID: arn:aws:elasticloadbalancing:ap-southea...er/app/lb-application/381e7108a00dd7e0)
module.ctm.aws_lb_target_group.target-group: Destroying... (ID: arn:aws:elasticloadbalancing:ap-southea...511160653395600000001/19b1ae34926b72aa)
module.ctm.aws_lb_target_group.target-group: Destruction complete after 1s
module.ctm.aws_launch_configuration.launch_configuration: Destruction complete after 1s
module.ctm.aws_lb.auto_scaling: Destruction complete after 2s
module.ctm.aws_security_group.sg_lb: Destroying... (ID: sg-0f77ab062e6a8d7e2)
module.ctm.aws_security_group.sg_lb: Still destroying... (ID: sg-0f77ab062e6a8d7e2, 10s elapsed)
module.ctm.aws_security_group.sg_lb: Still destroying... (ID: sg-0f77ab062e6a8d7e2, 20s elapsed)
module.ctm.aws_security_group.sg_lb: Still destroying... (ID: sg-0f77ab062e6a8d7e2, 30s elapsed)
module.ctm.aws_security_group.sg_lb: Still destroying... (ID: sg-0f77ab062e6a8d7e2, 40s elapsed)
module.ctm.aws_security_group.sg_lb: Still destroying... (ID: sg-0f77ab062e6a8d7e2, 50s elapsed)
module.ctm.aws_security_group.sg_lb: Still destroying... (ID: sg-0f77ab062e6a8d7e2, 1m0s elapsed)
module.ctm.aws_security_group.sg_lb: Still destroying... (ID: sg-0f77ab062e6a8d7e2, 1m10s elapsed)
module.ctm.aws_security_group.sg_lb: Still destroying... (ID: sg-0f77ab062e6a8d7e2, 1m20s elapsed)
module.ctm.aws_security_group.sg_lb: Still destroying... (ID: sg-0f77ab062e6a8d7e2, 1m30s elapsed)
module.ctm.aws_security_group.sg_lb: Still destroying... (ID: sg-0f77ab062e6a8d7e2, 1m40s elapsed)
module.ctm.aws_security_group.sg_lb: Still destroying... (ID: sg-0f77ab062e6a8d7e2, 1m50s elapsed)
module.ctm.aws_security_group.sg_lb: Still destroying... (ID: sg-0f77ab062e6a8d7e2, 2m0s elapsed)
module.ctm.aws_security_group.sg_lb: Destruction complete after 2m5s

Destroy complete! Resources: 9 destroyed.
```
