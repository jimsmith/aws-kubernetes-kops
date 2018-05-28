#!/bin/sh

source ./common-envs.sh

# Create Security Group for ALB Ingress and attach to kubernetes worker ec2 instances
# Issue you will get if not is: Load Balancing -> Target Groups -> Status `unhealthy` & `None of these Availability Zones contains a healthy target. Requests are being routed to all targets.`


# 1 - Create Security Group
ALB_SG=$(aws ec2 --region $AWS_REGION create-security-group --group-name ALBIngressSecurityGroup --description "Security group for Kubernetes ALB Ingress" --vpc-id $VPC_ID --output text)
echo $ALB_SG

# 2 - Tag Security Group
aws ec2 --region $AWS_REGION create-tags --resources $ALB_SG --tags Key=Name,Value=kubernetes-alb-ingress

# 3 - Create ingress rule - kubernetes access
aws ec2 --region $AWS_REGION authorize-security-group-ingress --group-id $ALB_SG --protocol all --cidr $NETWORK_CIDR

# HTTPS
aws ec2 --region $AWS_REGION authorize-security-group-ingress --group-id $ALB_SG \
--ip-permissions '[{"IpProtocol": "tcp", "FromPort": 443, "ToPort": 443, "IpRanges": [{"CidrIp": "0.0.0.0/0", "Description": "HTTPS access"}]}]'

#HTTP
aws ec2 --region $AWS_REGION authorize-security-group-ingress --group-id $ALB_SG \
--ip-permissions '[{"IpProtocol": "tcp", "FromPort": 80, "ToPort": 80, "IpRanges": [{"CidrIp": "my-ip-address-here/32", "Description": "HTTP access"}]}]'


# 4 - confirm ingress rule created
aws ec2 --region $AWS_REGION describe-security-groups --group-ids=$ALB_SG --output text

