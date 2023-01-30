#!/bin/sh

echo "Setting up trashcan demo"
PX_POD=$(kubectl get pods -l name=portworx -n kube-system -o jsonpath='{.items[0].metadata.name}')

kubectl exec $PX_POD -n kube-system -- /opt/pwx/bin/pxctl cluster options update --volume-expiration-minutes 720 
sleep 10 
kubectl apply -f trashcan-sc.yaml
sleep 5
kubectl create ns trashcan
sleep 5 

kubectl apply -f postgres-db-tc.yaml -n trashcan
sleep 30 

kubectl apply -f k8s-webapp-tc.yaml -n trashcan
sleep 60

echo "Application Endpoint:"
kubectl get svc -n trashcan
