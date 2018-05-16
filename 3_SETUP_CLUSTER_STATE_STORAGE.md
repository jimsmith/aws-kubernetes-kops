### Cluster State Storage

Create S3 Bucket for Kops configuration storage.

In order to store the state of your cluster, and the representation of your cluster, we need to create a dedicated S3 bucket for `kops` to use. This bucket will become the source of truth for our cluster configuration. 

In this guide we'll call this bucket `test-eu-west-1-k8s-cluster-state-store` but you should add a custom prefix as bucket names need to be unique within S3 global namespace.

```
export AWS_PROFILE=mylocal-test-kops
export AWS_REGION=eu-west-1
export PROJECT=test
aws s3 ls


KOPS_S3_BUCKET="${PROJECT}-${AWS_REGION}-k8s-cluster-state-store"
aws s3api create-bucket --bucket ${KOPS_S3_BUCKET} --region ${AWS_REGION} --create-bucket-configuration LocationConstraint=${AWS_REGION}
aws s3api wait bucket-exists --bucket ${KOPS_S3_BUCKET}
aws s3api put-bucket-versioning --region ${AWS_REGION} --bucket ${KOPS_S3_BUCKET} --versioning-configuration Status=Enabled
aws s3 ls
aws s3 ls ${KOPS_S3_BUCKET}
```
