```
source ./common-envs.sh
```

ADD TAGS TO SUBNET WHERE ALBS SHOULD BE DEPLOYED TO | PUBLIC SUBNET
----------------------------------------------------| =============

`./1_alb-ingress-controller-add-tags-subnet.sh`


Create Security Group for ALB Ingress and attach to kubernetes worker ec2 instances.

Issue you will get if not is: Load Balancing -> Target Groups -> Status `unhealthy` & `None of these Availability Zones contains a healthy target. Requests are being routed to all targets.`

`./2_create-sg-alb-ingress.sh`


-----------------------------------------------------------------------------------------------------------------------------------------------------------------

- Create Cluster Configuration
------------------------------

```
vi existing_vpc_env.sh
cd ../


source public_cluster/existing_vpc_env.sh
export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)

./create_cluster.sh public_cluster/existing_vpc_env.sh
```

------------------------------------------------------------

- Deploy Kubernetes Cluster on AWS
----------------------------------

Must specify --yes to apply changes

Cluster configuration has been created.

Suggestions:
 * list clusters with: `kops get cluster`
 * edit this cluster with: `kops edit cluster ha.eu-west-1.pub.k8s.project1.test.example.com`
 * edit your node instance group: `kops edit ig --name=ha.eu-west-1.pub.k8s.project1.test.example.com nodes`
 * edit your master instance group: `kops edit ig --name=ha.eu-west-1.pub.k8s.project1.test.example.com master-eu-west-1a`

Finally configure your cluster with: `kops update cluster ha.eu-west-1.pub.k8s.project1.test.example.com --yes`

`kops update cluster ${NAME} --yes`

- You will have to give Kubernetes sometime for it to be created and become available for use, usually within 10 minutes or so.

A simple Kubernetes API call can be used to check if the API is online and listening. Let's use `kubectl` to check the nodes.

`kubectl get nodes`


You will see a list of nodes that should match the `--zones` flag defined earlier. This is a great sign that your Kubernetes cluster is online and working.

Also `kops` ships with a handy validation tool that can be ran to ensure your cluster is working as expected.

`kops validate cluster`

You can look at all the system components with the following command.

```
kubectl -n kube-system get po

kubectl -n kube-system get pods
kubectl cluster-info
kubectl get nodes --show-labels
kubectl get po,deploy,svc,pvc,rs,cm --output=wide --namespace=kube-system
kubectl get all --all-namespaces=true --output=wide

kubectl config view
```

--------------------------------------------------------

DO THIS AFTER CLUSTER IS CREATED
--------------------------------
5 - attach ALB Security Group to nodes security group
i.e: 'Security group for nodes' -> sg-xxxxxxxx -> Inbound ->  `All traffic All All sg-yyyyyyyy (ALBIngressSecurityGroup)`

`./4_attach-alb-sg-to-nodes-sg.sh`


-------------------------------------------------------------------------------------------------------------------------


# Retrieve the credentials:
`kubectl config view`

https://api.ha.eu-west-1.pub.k8s.project1.test.example.com
username and password is retrieved from `kubectl config view` command

Execute the below command to find the admin user's password:
`kops get secrets kube --type secret -oplaintext`


- Deploy Kubernetes Dashboard
`kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml`

        ```
        secret "kubernetes-dashboard-certs" created
        serviceaccount "kubernetes-dashboard" created
        role.rbac.authorization.k8s.io "kubernetes-dashboard-minimal" created
        rolebinding.rbac.authorization.k8s.io "kubernetes-dashboard-minimal" created
        deployment.apps "kubernetes-dashboard" created
        service "kubernetes-dashboard" created
        ```


Access Dashboard UI

`kubectl cluster-info | grep "Kubernetes master" | awk '{print $6}'`

https://api.ha.eu-west-1.pub.k8s.project1.test.example.com/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/

Enter credentials from above that you retrieved.

- Deploy Cluster Monitoring
`https://github.com/fteychene/kops-kubernetes-demo/blob/master/README.md`

- Deploy Heapster
`kubectl create -f ../cluster-monitoring/heapster/`

        ```
        deployment.extensions "monitoring-grafana" created
        service "monitoring-grafana" created
        clusterrolebinding.rbac.authorization.k8s.io "heapster" created
        serviceaccount "heapster" created
        deployment.extensions "heapster" created
        service "heapster" created
        deployment.extensions "monitoring-influxdb" created
        service "monitoring-influxdb" created
        ```

`cd alb/`
Then follow BOOTSTRAP.md steps
