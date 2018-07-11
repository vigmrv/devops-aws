provider "aws" {
		access_key= "xxxxx"
		secrect_key = "xxxxxx"
		region = ""
		}

#to create vpc 

resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/16" #example
}

#to create subnet for web servers

resource "aws_subnet" "web" {
  vpc_id     = "${aws_vpc.test_vpc.id}"
  name       = "web"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

#to create subnet for app servers

resource "aws_subnet" "app" {
  vpc_id     = "${aws_vpc.test_vpc.id}"
  name       = "app"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = false
}

#to create subnet for db servers

resource "aws_subnet" "db" {
  vpc_id     = "${aws_vpc.test_vpc.id}"
  name       = "db"
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = false
}

#define the most recent ami for linux

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "linuxami"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }
  }

#Create security group for web server  

resource "aws_security_group" {
  name        = "web_sg"
  description = " allow SSH port, port 80 and port 443 to the external internet"
  vpc_id      = "${data.aws_vpc.test_vpc.id}"
  egress_rules = ["http-80-tcp", "ssh-22-tcp","https-443-tcp"]
 
}

#Creates a WEB EC2 instance

resource "ec2" {
       instance_count = 1
       name  = "WEB01"
       ami   = "${data.aws_ami.amazon_linux.id}"
       instance_type = "t2.micro"
       subnet_id     = "${aws_subnet.web.id}"
       vpc_security_group_ids  = "${aws_security_group.web_sg.id}"
       associate_public_ip_address = true
}

#Assign an elastic ip address to web ec2 instance

resource "aws_eip" "x.x.x.x" {
  instance = "${aws_instance.WEB01.id}"
  vpc      = true
}

#Create security group for app server

resource "aws_security_group" {
  name        = "app_sg"
  description = " allow SSH port (to external internet) and whatever ports necessarily for the app to work (internal network only)"
  vpc_id      = "${data.aws_vpc.test_vpc.id}"
  egress_rules = ["ssh-22-tcp"]
  igress_rules = ["http-80-tcp","https-443-tcp","remotedesktop-3389-tcp"]
 
}

#Creates a APP EC2 instance

resource "ec2" {
       instance_count = 1
       name  = "APP01"
       ami   = "${data.aws_ami.amazon_linux.id}"
       instance_type = "t2.large"
       subnet_id     = "${aws_subnet.app.id}"
       vpc_security_group_ids  = "${aws_security_group.app_sg.id}"
       associate_public_ip_address = false
}

#Create security group for db server

resource "aws_security_group" {
  name        = "db_sg"
  description = "  allow SSH port (to external internet) and the database ports (internal network only)"
  vpc_id      = "${data.aws_vpc.test_vpc.id}"
  egress_rules = ["ssh-22-tcp"]
  igress_rules = ["Oracle SQL*Net Listener-1521-tcp"]
 
}

#Creates a DB EC2 instance

resource "ec2" {
       instance_count = 1
       name  = "DB01"
       ami   = "${data.aws_ami.amazon_linux.id}"
       instance_type = "t2.xlarge"
       subnet_id     = "${aws_subnet.db.id}"
       vpc_security_group_ids  = "${aws_security_group.db_sg.id}"
       associate_public_ip_address = false
}
