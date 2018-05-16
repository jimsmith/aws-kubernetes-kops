#!/bin/sh

source ./common-envs.sh

## DO THIS AFTER CLUSTER IS CREATED
# 5 - attach ALB Security Group to nodes security group
# i.e: 'Security group for nodes' -> sg-123a456b -> Inbound ->  `All traffic All All sg-abcdef12 (ALBIngressSecurityGroup)`

# 1) get nodes instance id's to attach ALB SG onto
NODES_SG=$(aws ec2 --region $AWS_REGION describe-instances --filters=Name=tag:Name,Values=nodes.${NAME} --output text | sort -u | grep SECURITYGROUPS| awk '{print $2}')
echo $NODES_SG

# Describe the above Security Group
aws ec2 --region $AWS_REGION describe-security-groups --group-ids $NODES_SG --output table

# 2) attach ALB Security Group to nodes Security Group
aws ec2 --region $AWS_REGION authorize-security-group-ingress --group-id $NODES_SG --protocol all --source-group $ALB_SG

# Confirm above is attached
aws ec2 --region $AWS_REGION describe-security-groups --group-ids $NODES_SG --output table

