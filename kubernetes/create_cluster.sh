#!/bin/sh

# Jim Smith - 12/04/2018 - Initial Wrapper Script for creating Kubernetes Cluster Configuration on AWS

# USAGE:
# ./create_cluster.sh public_cluster/existing_vpc_env.sh
# ./create_cluster.sh private_cluster/existing_vpc_env.sh


#!/bin/sh

dirname=`dirname $0`
. ${dirname}/$1

echo "========================================================================="
echo "!!! You are about to CREATE a Kubernetes Cluster Configuration on AWS !!!"
echo "========================================================================="
echo -e
        echo "Please confirm that you wish to CREATE the following Kubernetes Cluster Configuration on AWS:"
        echo -e
        echo "  K8S Cluster Name: ${NAME}"
        echo "  AWS Profile: ${AWS_PROFILE}"
        echo "  AWS Region: ${AWS_REGION}"
        echo -e
        echo "(N/y)"
        echo -e
        read answer
        case $answer in
        Y*|y*)   break;;
        N*|n*)   exit;;
       esac

echo -e
echo "Creating Kubernetes Cluster Configuration $NAME in $AWS_PROFILE account"
echo -e

kops create cluster \
    --cloud aws \
    --state ${KOPS_STATE_STORE} \
    --ssh-public-key ${SSH_PUBLIC_KEY} \
    --admin-access "${ADMIN_ACCESS}" \
    --authorization "${AUTHORIZATION}" \
    --zones "${ZONES}" \
    --dns "${DNS_ZONE}" \
    --dns-zone "${DNS_ZONE_ID}" \
    --node-tenancy ${NODE_TENANCY} \
    --node-count ${NODE_COUNT} \
    --node-size ${NODE_SIZE}  \
    --node-volume-size ${NODE_VOLUME_SIZE} \
    --master-tenancy ${MASTER_TENANCY} \
    --master-count ${MASTER_COUNT} \
    --master-size ${MASTER_SIZE} \
    --master-volume-size ${MASTER_VOLUME_SIZE} \
    --master-zones ${MASTER_ZONES} \
    --vpc ${VPC_ID} \
    --subnets ${PRIVATE_SUBNET_IDS} \
    --utility-subnets ${UTILITY_SUBNET_IDS} \
    --topology private \
    --bastion=${BASTION} \
    --network-cidr "${NETWORK_CIDR}" \
    --networking calico \
    --kubernetes-version ${KUBERNETES_VERSION} \
    --cloud-labels "${CLOUD_LABELS}" \
    --image "${IMAGE}" \
    --api-loadbalancer-type ${API_LB_TYPE} \
    --associate-public-ip=${MASTER_ASSOCIATE_PUBLIC_IP} \
    ${NAME}
