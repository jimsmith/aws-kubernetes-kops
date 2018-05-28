# Kubernetes 'My Test Cluster' Private Cluster for an existing VPC

# source this file first

# source in common variables as well.
. private_cluster/common-envs.sh


export AWS_PROFILE=mylocal-test-kops                                                 # KOPS IAM User
# export AWS_REGION=eu-west-1


export CLOUD_LABELS="Owner=Jim Smith,Environment=testpriv,Type=k8s,Provisioner=kops"
export NAME="ha.${AWS_REGION}.${K8S_CLUSTER_DNS_TLD}"

export KOPS_STATE_STORE=s3://test-${AWS_REGION}-k8s-cluster-state-store

export ZONES=${ZONES:-"${AWS_REGION}a,${AWS_REGION}b,${AWS_REGION}c"}
export MASTER_ZONES=${MASTER_ZONES:-"${AWS_REGION}a,${AWS_REGION}b,${AWS_REGION}c"}


export SSH_PUBLIC_KEY="~/.ssh/${AWS_REGION}-mylocal-test-kops_id_rsa.pub"       # https://github.com/kubernetes/kops/blob/master/docs/security.md#ssh-access

# Dynamically 32GB EBS gets provisioned)
export BASTION="false"                                                          # Provide an external facing point of entry into a network containing private network instances - https://github.com/kubernetes/kops/blob/master/docs/bastion.md
export API_LB_TYPE="internal"                                                   # API Load Balancer Ingress - https://github.com/kubernetes/kops/blob/master/docs/cluster_spec.md

# 12/04/2018
# aws ec2 describe-images --region=${AWS_REGION} --owner=595879546273 --filters "Name=virtualization-type,Values=hvm" "Name=name,Values=CoreOS-stable*" --query 'sort_by(Images,&CreationDate)[-1].{id:ImageLocation}'
export IMAGE="595879546273/CoreOS-stable-1688.5.3-hvm"                          # https://github.com/kubernetes/kops/blob/master/docs/images.md



# VPC Settings
export PRIVATE_SUBNET_IDS="${SUBNET_PRIVATE_1},${SUBNET_PRIVATE_2},${SUBNET_PRIVATE_3}" # Private Subnet IDs
export UTILITY_SUBNET_IDS="${PRIVATE_SUBNET_IDS}"

# 11/05/2018 14:55 BST - Initial test went with 0.0.0.0/0 for internal office cidr blocks
export ADMIN_ACCESS="${NETWORK_CIDR},0.0.0.0/0"                                 # https://github.com/kubernetes/kops/blob/master/docs/arguments.md#admin-access


# Route53 Zone ID
export DNS="public"
export DNS_ZONE_ID="${K8S_DNS_ZONE_ID}"                                         # https://github.com/kubernetes/kops/blob/master/docs/arguments.md#dns-zone


# Authorization
export AUTHORIZATION="AlwaysAllow"                                              # Authorization mode to use: AlwaysAllow or RBAC (default "RBAC")

# Master (dynamically etcd-events EBS gets provisioned 20G | etcd-main EBS gets provisioned 20GB)
export MASTER_TENANCY="default"
export MASTER_COUNT=3                                                           # Set based on the AZs in your VPC
export MASTER_SIZE="t2.micro"
export MASTER_VOLUME_SIZE="10"                                                  # in GB
export MASTER_ASSOCIATE_PUBLIC_IP="false"

# Nodes/Workers
export NODE_TENANCY="default"
export NODE_SIZE="t2.micro"
export NODE_COUNT=3                                                             # Set based on the AZs in your VPC
export NODE_VOLUME_SIZE="50"                                                   # in GB

# Kubernetes Version of deployment
export KUBERNETES_VERSION="1.9.3"
