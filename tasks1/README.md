Basic EC2 instance

Configuration in this directory creates three EC2 instances (web,db,app) respectively. This example outputs instance ids, securitygroupids, vpcids, subnet ids 

Usage
To run this example execute the below commands as follows

$ terraform init
$ terraform plan
$ terraform apply

Note 
This example may create resources which can cost money. Run terraform destroy when you don't need these resources.

Outputs

Name	          		Description
ids	              		List of IDs of EC2 instances 
vpc_security_group_ids	List of VPC security group ids assigned to EC2 instances 
vpc_subnet_ids			List of VPC subnet ids assigned to EC2 instances


