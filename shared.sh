#!/bin/sh

kubectl create ns sharedservice

sleep 60
kubectl apply -f sharedpvc.yaml -n sharedservice 
sleep 10

kubectl apply -f nginxpod.yaml -n sharedservice
sleep 60

kubectl exec -n sharedservice $(kubectl get pods -n sharedservice -o=jsonpath='{.items[0].metadata.name}') -- cat /mnt/shared.log

