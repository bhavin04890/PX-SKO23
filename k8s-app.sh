#!/bin/sh

kubectl create ns demo 
sleep 5 

kubectl apply -f postgres-db.yaml -n demo
sleep 30 

kubectl apply -f k8s-webapp.yaml -n demo
sleep 60

echo "Application Endpoint:"
kubectl get svc -n demo 
