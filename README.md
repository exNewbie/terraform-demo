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


## Deploy stack
Terraform will spin up a new stack.
```
./terraform apply -auto-approve
```

The last line is ***the Load Balancer endpoint***. When it is browsed, it will show an instance ID of one of EC2 instances.


## Remove the stack
Terraform will remove sources it created earlier.
```
./terraform destroy -auto-approve
```

