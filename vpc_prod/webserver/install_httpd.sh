#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://100.25.77.5/latest/meta-data/local-ipv4`
echo "<h1>Welcome to ACS730 ${prefix}! My private IP is $myip<font color="RED"> in ${env} environment</font></h1><br>Built by Terraform!"  >  /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
