#!/bin/sh


# https://github.com/paulbouwer/hello-kubernetes
echo -e "----------------------------------------------"
echo -e "Deploying hello-kubernetes smoketest container"
echo -e "----------------------------------------------"
kubectl run hello-kubernetes --replicas=1 --image=paulbouwer/hello-kubernetes:1.4 --port=8080
sleep 60s

# Get Deployments
echo -e "Get Deployment..."
kubectl get deployments hello-kubernetes

# Describe Deployments
echo "Describe Deployment..."
kubectl describe deployments hello-kubernetes

# Expose Service
echo -e "---------------------------------------------"
echo -e "Exposing hello-kubernetes smoketest container"
echo -e "---------------------------------------------"
kubectl expose deployment hello-kubernetes --type=NodePort --name=hello-kubernetes-example-service
sleep 5s

# Describe Services
echo -e "Describe Services..."
kubectl describe services hello-kubernetes-example-service
kubectl describe deployments hello-kubernetes

