export AWS_PROFILE=mylocal-test-kops
export AWS_DEFAULT_REGION=eu-west-1
export AWS_REGION=$AWS_DEFAULT_REGION
export NETWORK_CIDR=172.16.0.0/23
export VPC_ID=vpc-yyyyyyyy


export SUBNET_PRIVATE_1=subnet-yyyyyyyy                         # test-kubernetes-private-dev-private-AZ1
export SUBNET_PRIVATE_2=subnet-yyyyyyyy                         # test-kubernetes-private-dev-private-AZ2
export SUBNET_PRIVATE_3=subnet-yyyyyyyy                         # test-kubernetes-private-dev-private-AZ3


export K8S_DNS_ZONE_ID=YYYYYYYYYYYYY                            # k8s.project1.test.example.com        | Kubernetes Operational Management
export K8S_CLUSTER_DNS_TLD=priv.k8s.project1.test.example.com   # Private Kubernetes DNS TLD
