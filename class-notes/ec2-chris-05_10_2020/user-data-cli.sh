# EXAMPLE-1 Manual httpd setup (AWS Console)
# EXAMPLE-2 User data httpd setup (AWS Console)
# EXAMPLE-3 Web server with aws CLI(Command Line Interface)

# Use AWS EC2 CLI
# aws ec2 run-instances
# --image-id ami-0f7919c33c90f5b58
# --count 1
# --instance-type t2.micro
# --key-name chrisohiocw.pem
# --user-data file://user-data.sh
# --subnet-id subnet-4de77701
# --security-group-ids sg-0066a6e7511eaa5ed

aws ec2 run-instances \
    --image-id ami-0f7919c33c90f5b58 \
    --count 1 \
    --instance-type t2.micro \
    --key-name chris.ohio.cw \
    --user-data file://user-data.sh \
    --subnet-id subnet-4de77701 \
    --security-group-ids sg-0066a6e7511eaa5ed