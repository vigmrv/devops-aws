1)Compose infrastructure code to create a three tier environment (EC2 instances: web, app, database) on AWS as follows:
 Set 3 subnets: name them "web", "app", "db" respectively.
 Create the web EC2 instance in the "web" subnet. Set the name tag to "WEB01".
 Create an Elastic IP address and place on the "WEB01" EC2 instance.
 Create the app EC2 instance in "app" subnet. Set the name tag to "APP01".
 Create the database EC2 instance in "db" subnet. Set the name tag to "DB01".
 On security groups:
o For the "WEB01" instance: allow SSH port, port 80 and port 443 to the external internet.
o For the "APP01" instance: allow SSH port (to external internet) and whatever ports necessarily for the app to work (internal network only)
o For the "DB01" instance: allow SSH port (to external internet) and the database ports (internal network only)
o In other words, set sensible and secure settings for the security groups.
Note: Set up the above by using the following tool(s): Terraform

2) Compose Ansible code to set up OpenCMS on the infrastructure that you created in Step 1.
 For the WEB01 instance, install Apache httpd and configure it to act as a frontend to the APP01 server See http://documentation.opencms.org/opencms-documentation/server-installation/apache-webserver-configuration/
 For the DB01 instance, install mysql server on it and configure it as necessary.
 For the APP01 instnace, install Apache Tomcat server and install the OpenCMS app on it. If possible configure the OpenCMS application via Ansible. See http://documentation.opencms.org/opencms-documentation/server-installation/tomcat-configuration/ http://documentation.opencms.org/opencms-documentation/server-installation/installing-opencms/the-setup-script/ http://www.opencms.org/en/development/installation/server.html
 Setup SSH key logins for all instance. There should 1 private that can be used to logged into all 3 instances.
 Disable password login for all 3 EC2 instances.
 Disable SELinux if necessary otherwise leave it enabled.

3) Take backup of the instances using AWS Lambda. (Need to take image of the instances incremental).
