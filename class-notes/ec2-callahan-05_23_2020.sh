# 05-23-2020
# AWS Lab Session - Callahan
# EC2 - Auto Scaling 
# created launch template for Amazon Linux 2 with user data as below 
#!/bin/bash
#update os
yum update -y
#install apache server
yum install -y httpd
# get private ip address of ec2 instance using instance metadata
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` \
&& PRIVATE_IP=`curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4`
# get public ip address of ec2 instance using instance metadata
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` \
&& PUBLIC_IP=`curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4` 
# get date and time of server
DATE_TIME=`date`
# set all permissions 
chmod -R 777 /var/www/html
# create a custom index.html file
echo "<html>
<head>
    <title> ELB with Call</title>
</head>
<body>
    <h1>Testing Application Load Balancer with Call</h1>
    <p>This web server is launched from launch template by YOUR_NAME</p>
    <p>This instance is created at <b>$DATE_TIME</b></p>
    <p>Private IP address of this instance is <b>$PRIVATE_IP</b></p>
    <p>Public IP address of this instance is <b>$PUBLIC_IP</b></p>
</body>
</html>" > /var/www/html/index.html
# start apache server
systemctl start httpd
systemctl enable httpd
# created security with http and ssh rules
# created loadbalancer together with target group
# do not add any instance to the target group
# auto scaling group using launch template and target group 
# within auto scaling group, setup simple policy for both decrease and increase grop size
# health check type is set to ELB
# simple policy for increasing the instance number, 
    # select cpu usage >= 50%, 
    # setup an alarm and sns notification,
    # add 1 instance
    # wait 30s
# simple policy for decreasign the instance number, 
    # select cpu usage <= 20%, 
    # setup an alarm and sns notification,
    # remove 1 instance
    # wait 30s
# monitored the instance and health checks and interpret how the health checks are affectign auto scaling group
# changed heath check type to EC2, and monitor
# edited auto scaling group configuration and changed minimum number of instances
# stressed currently running instances with commands below 
sudo amazon-linux-extras install epel -y
sudo yum install -y stress
uptime
stress --cpu 2 --timeout 300 &
watch uptime
# checked email for sns notifications
# checked the cloud-watch for alarm state
# monitored affect of our stress command which caused asg to add extra instances
# changed launched template with new version
# terminated all instances within dashboard
# monitored auto scaling group which launched new instances with new template version