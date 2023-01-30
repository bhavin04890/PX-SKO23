#!/bin/sh

kubectl create -f pvc-from-snap.yaml -n demo
sleep 2
kubectl get pvc px-postgres-snap-clone -n demo
sleep 5
kubectl delete -f postgres-db.yaml -n demo
sleep 5
kubectl apply -f postgres-db-restore.yaml -n demo
sleep 5
kubectl scale deployment.apps/k8s-counter-deployment --replicas=0 -n demo
sleep 5 
kubectl scale deployment.apps/k8s-counter-deployment --replicas=1 -n demo
sleep 5
kubectl get pods -n demo

