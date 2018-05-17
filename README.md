So this is my github repository on my own testing on AWS for getting Kubernetes provisioned on AWS during my own time and works for me.


## Setup
Setting up your Kubernetes Miniconda environment is as follows:

1) Run the following command:
`source setup_env.sh`

This will setup your isolated working environment.
---
---

2) Follow instructions from:\
   - `1_SETUP_IAM_USER-EC2_KEYPAIR.md`
   - `2_SETUP_DNS.md`
   - `3_SETUP_CLUSTER_STATE_STORAGE.md`
   - `kubernetes-cluster/INITIAL_SETUP.md`


Kubernetes Public Cluster (private subnet):\
`kubernetes/public_cluster/WALK-THRU.md`

Kubernetes Private Cluster (private subnet):\
`kubernetes/private_cluster/WALK-THRU.md`


## Activate
To manually activate your existing environment run the following:
`source activate.sh`

---
---
## Deactivate
To deactivate your current working environment run the following:
`source deactivate.sh`
---
---
