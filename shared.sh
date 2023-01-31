#!/bin/sh

#kubectl create ns sharedservice

#sleep 60
#kubectl apply -f sharedpvc.yaml -n sharedservice 
#sleep 10

#kubectl apply -f nginxpod.yaml -n sharedservice
#sleep 60

#kubectl exec -n sharedservice $(kubectl get pods -n sharedservice -o=jsonpath='{.items[0].metadata.name}') -- cat /mnt/shared.log
#sleep 10

echo "\n\n\n"

PX_POD=$(kubectl get pods -l name=portworx -n kube-system -o jsonpath='{.items[0].metadata.name}')

VolName=$(kubectl exec $PX_POD -n kube-system -- /opt/pwx/bin/pxctl volume list | grep "10 GiB" | awk '{print $2}' )

kubectl exec $PX_POD -n kube-system -- /opt/pwx/bin/pxctl volume inspect $VolName

echo "\n\n\n"

echo "Find the sharedv4 service endpoint" 
kubectl describe svc -n sharedservice 

echo "\n\n"
echo "Looking for the specific node" 
kubectl get nodes -o wide
