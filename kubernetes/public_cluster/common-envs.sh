export AWS_PROFILE=mylocal-test-kops
export AWS_DEFAULT_REGION=eu-west-1
export AWS_REGION=$AWS_DEFAULT_REGION
export NETWORK_CIDR=192.168.0.0/22
export VPC_ID=vpc-xxxxxxxx


export SUBNET_PRIVATE_1=subnet-xxxxxxxx                         # test-kubernetes-public-dev-private-AZ1
export SUBNET_PRIVATE_2=subnet-xxxxxxxx                         # test-kubernetes-public-dev-private-AZ2
export SUBNET_PRIVATE_3=subnet-xxxxxxxx                         # test-kubernetes-public-dev-private-AZ3


export SUBNET_PUBLIC_1=subnet-xxxxxxxx                          # test-kubernetes-public-dev-public-AZ1
export SUBNET_PUBLIC_2=subnet-xxxxxxxx                          # test-kubernetes-public-dev-public-AZ2
export SUBNET_PUBLIC_3=subnet-xxxxxxxx                          # test-kubernetes-public-dev-public-AZ3

export K8S_DNS_ZONE_ID=XXXXXXXXXXXXX                            # k8s.project1.test.example.com        | Kubernetes Operational Management
export K8S_CLUSTER_DNS_TLD=pub.k8s.project1.test.example.com    # Public Kubernetes DNS TLD
