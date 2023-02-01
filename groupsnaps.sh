#!/bin/sh

echo "group snaps"

kubectl apply -f group-sc.yaml

kubectl create ns groupsnaps
sleep 5 

kubectl apply -f cassandra-presnap-rule.yaml -n groupsnaps
sleep 5

kubectl apply -f cassandra-app.yaml -n groupsnaps
sleep 30

kubectl get pods,pvc -n groupsnaps
sleep 5

echo "Adding data to Cassandra"
kubectl exec -it cassandra-0 -n groupsnaps -- nodetool status  
