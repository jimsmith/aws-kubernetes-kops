
`./00_deploy_hello-kubernetes-container.sh`

## To delete
`kubectl delete deployment hello-kubernetes`

# this also deletes the containers
`kubectl delete service hello-kubernetes-example-service`

-------------------------------------------------------------------------


Deploy ALB Ingress Controller
-----------------------------

The alb-ingress-controller (container) communicates to AWS API periodically with its configuration which was overriding any other changes (so even using CloudFormation, etc) the container itself is it's one true source of configuration state)


`vi 1_hello-kubernetes-alb-ingress-controller.yaml`
Amend the following:
`CLUSTER_NAME`


`vi 2_hello-kubernetes-alb-ingres.yaml`

Amend the following as a minimum:

```
alb.ingress.kubernetes.io/security-groups
alb.ingress.kubernetes.io/subnets
```

The security group, enter the ALB_SG value



`kubectl apply -f 0_default-backend.yaml`
`kubectl apply -f 1_hello-kubernetes-alb-ingress-controller.yaml`

Workloads -> Pods -> alb-ingress-controller-randomstring -> click on Logs and confirm container launches then do the next step below
Note: It will take around 3 minutes before the container communicates to AWS API

`kubectl apply -f 2_hello-kubernetes-alb-ingres.yaml`

rinse and repeat as above check logs and see the status - pre-requisite the actual container/service that ALB is to use requires to be operational and ready
re-running the above command of 2_ will push out configuration changes for this container to use


### To delete
`kubectl delete -f 2_hello-kubernetes-alb-ingres.yaml`

`kubectl delete -f 1_hello-kubernetes-alb-ingress-controller.yaml`

`kubectl delete -f 0_default-backend.yaml`


Update DNS record to use ALB
----------------------------

Route53         |       Type A  | Alias YES     | ALB Resource Name        |       hello-kubernetes.project1.test.example.com




Confirm URL works:
`https://hello-kubernetes.project1.test.example.com/`

