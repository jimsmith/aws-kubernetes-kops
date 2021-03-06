#!/bin/sh

source ./common-envs.sh

# ADD TAGS TO SUBNET WHERE ALBS SHOULD BE DEPLOYED TO | PUBLIC SUBNET
# ----------------------------------------------------| =============


# https://github.com/coreos/alb-ingress-controller/blob/master/docs/walkthrough.md
#        Add the following Tags to the Public subnets for Kubernetes ALB Ingress
#        10 - Add tags to subnets where ALBs should be deployed.
#        Key: kubernetes.io/role/alb-ingress
#        Value: 1
#        https://eu-west-1.console.aws.amazon.com/vpc/home?region=us-east-2#subnets:filter=public

aws ec2 create-tags --resources $SUBNET_PUBLIC_1 --tags Key=kubernetes.io/role/alb-ingress,Value=1
aws ec2 create-tags --resources $SUBNET_PUBLIC_2 --tags Key=kubernetes.io/role/alb-ingress,Value=1
aws ec2 create-tags --resources $SUBNET_PUBLIC_3 --tags Key=kubernetes.io/role/alb-ingress,Value=1
aws ec2 describe-subnets --filters Name=tag:kubernetes.io/role/alb-ingress,Values=1 --output table

