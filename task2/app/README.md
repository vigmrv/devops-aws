Basics

This ansible code installs the apache tomcat on the AWS EC2 instance APP01, deploys opencms on the APP01 server,  setup ssh key login for all the instances with private key to be used for logging in to the instances, disables selinux , disables password login 

Usage

To run this example execute the below commands as follows

#ansible-playbook apache_tomcat.yml
#ansible-playbook deploy_opencms.yml
#ansible-playbook sshkeys.yml

