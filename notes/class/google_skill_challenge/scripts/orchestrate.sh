#!/bin/bash

gcloud auth list
PROJECT=`gcloud config get-value project | grep qwiklabs`

CLUSTER_NAME='io'
gcloud config set compute/zone us-central1-b
gcloud container clusters create $CLUSTER_NAME

# Get sample code
gsutil cp -r gs://spls/gsp021/* .
cd orchestrate-with-kubernetes/kubernetes

# Quick kubernetes demo
kubectl create deployment nginx --image=nginx:1.10.0
# kubectl get pods
kubectl expose deployment nginx --port 80 --type LoadBalancer
wait 60
# kubectl get services

# Create pods

cat pods/monolith.yaml
kubectl create -f pods/monolith.yaml
# kubectl get pods
# kubectl describe pods monolith

# Interacting with pods
kubectl port-forward monolith 10080:80

#### Open new terminal

cd ~/orchestrate-with-kubernetes/kubernetes
#cat pods/secure-monolith.yaml
kubectl create secret generic tls-certs --from-file tls/
kubectl create configmap nginx-proxy-conf --from-file nginx/proxy.conf
kubectl create -f pods/secure-monolith.yaml
#cat services/monolith.yaml
kubectl create -f services/monolith.yaml

gcloud compute firewall-rules create allow-monolith-nodeport --allow=tcp:31000

kubectl label pods secure-monolith 'secure=enabled'
#kubectl get pods secure-monolith --show-labels

# Create deployments
kubectl create -f deployments/auth.yaml
kubectl create -f services/auth.yaml
kubectl create -f deployments/hello.yaml
kubectl create -f services/hello.yaml

kubectl create configmap nginx-frontend-conf --from-file=nginx/frontend.conf
kubectl create -f deployments/frontend.yaml
kubectl create -f services/frontend.yaml
#kubectl get services frontend
