#!/bin/sh

kubectl exec -n sharedservice $(kubectl get pods -n sharedservice -o=jsonpath='{.items[0].metadata.name}') -- cat /mnt/shared.log
sleep 5

echo "Check the service endpoint now"
kubectl describe svc -n sharedservice
sleep 5
