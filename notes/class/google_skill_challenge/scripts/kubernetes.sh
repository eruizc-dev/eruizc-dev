#!/bin/bash

gcloud auth list

CLUSTER_NAME='my-cluster'
gcloud config set compute/zone us-central1-a
gcloud container clusters create $CLUSTER_NAME

gcloud container clusters get-credentials $CLUSTER_NAME
kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0

kubectl expose deployment hello-server --type=LoadBalancer --port 8080
#kubectl get service

# Do manually
gcloud container clusters delete $CLUSTER_NAME
