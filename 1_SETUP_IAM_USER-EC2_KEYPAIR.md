### Setup IAM user

In order to build clusters within AWS we'll create a dedicated IAM user for kops. This user requires API credentials in order to use kops. Create the user, and credentials.

You can create the kops IAM user from the command line using the following:

```
export AWS_PROFILE=mylocal-test-kops
export AWS_REGION=eu-west-1

IAM_GROUP_NAME=kops
IAM_USER_NAME=kops

aws iam list-users

aws iam create-group --group-name ${IAM_GROUP_NAME}

aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name ${IAM_GROUP_NAME}
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRoute53FullAccess --group-name ${IAM_GROUP_NAME}
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name ${IAM_GROUP_NAME}
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/IAMFullAccess --group-name ${IAM_GROUP_NAME}
aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonVPCReadOnlyAccess --group-name ${IAM_GROUP_NAME}

aws iam create-user --user-name ${IAM_USER_NAME}
aws iam add-user-to-group --user-name ${IAM_USER_NAME} --group-name ${IAM_GROUP_NAME}

aws iam create-access-key --user-name ${IAM_USER_NAME}
```

-------------------------------------------------------------------------------------------------------------------------------

### Setup IAM User for buid and maintain of cluster management

```
## 08/05/2018 - ALB Ingress Controller IAM Policy
aws iam create-policy \
        --policy-name kube-alb-ingress-controller \
        --policy-document file://./kubernetes/mylocal-test-alb-ingress-controller-policy.json \
        --description 'requisite policy for ALB Ingress Controller for kubernetes'
```


# Attach Arn output above to IAM User
```
aws iam attach-user-policy --policy-arn arn:aws:iam::<aws-account-id>:policy/kube-alb-ingress-controller --user-name kops
```

------------------------------------------------------------------------------------------------------------------------------


You should record the SecretAccessKey and AccessKeyID in the returned JSON output, and then use them below:


# configure the aws client to use your new IAM user
```
vi ~/.aws/config

# AWS KOPS
[profile mylocal-test-kops]
region = eu-west-1
```

```
vi ~/.aws/credentials
[mylocal-test-kops]
aws_access_key_id = <AWS ACCESS KEY ID HERE>
aws_secret_access_key = <AWS SECRET ACCESS KEY HERE>
```

Next you export the AWS Profile for AWS CLI and kops to work with specifically only for this IAM User:
```
export AWS_PROFILE=mylocal-test-kops
aws iam list-users
```


# Because AWS CLI doesn't export these vars for kops to use, we export them now:
```
export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)

aws iam list-users
```


### Setup EC2 KeyPair

```
mkdir -p ./ec2-keypairs/
ssh-keygen -t rsa -b 2048 -N '' -C "aws-${AWS_REGION}-mylocal-test-kops-${DATE}" -f ./ec2-keypairs/${AWS_REGION}-mylocal-test-kops_id_rsa && echo "yes"
ls -la ./ec2-keypairs/
```

`KEYPAIR=$(cat ./ec2-keypairs/${AWS_REGION}-mylocal-test-kops_id_rsa.pub)`

`aws --profile $AWS_PROFILE --region $AWS_REGION ec2 import-key-pair --key-name ${AWS_REGION}-mylocal-test-kops_id_rsa.pub --public-key-material "${KEYPAIR}"`
`aws --profile $AWS_PROFILE --region $AWS_REGION ec2 describe-key-pairs --output table`
