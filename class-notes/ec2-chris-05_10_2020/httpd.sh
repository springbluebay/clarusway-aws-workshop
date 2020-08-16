#!/bin/bash

#STEP-1: install httpd(apache) service
sudo yum install httpd -y
#STEP-2: if not exist install wget
sudo yum install wget -y
#STEP-3: enable the service
sudo chkconfig httpd on #sudo systemctl enable httpd.service
#STEP-4: download content to host
cd /var/www/html
sudo wget https://raw.githubusercontent.com/awsdevopsteam/route-53-2/master/index.html
sudo wget https://raw.githubusercontent.com/awsdevopsteam/route-53-2/master/ryu.jpg

#STEP-5: start the service
sudo service httpd start

#started listening port 80

#STEP-6 Configure security groups
# Click on Add Rule
# Select HTTP Type
# Source -> Anywhere
# Click on  Save