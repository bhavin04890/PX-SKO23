#!/bin/sh

echo "Cleaning up trashcan demo"
PX_POD=$(kubectl get pods -l name=portworx -n kube-system -o jsonpath='{.items[0].metadata.name}')

kubectl exec $PX_POD -n kube-system -- /opt/pwx/bin/pxctl cluster options update --volume-expiration-minutes 0
sleep 10 

kubectl delete -f k8s-webapp-tc.yaml -n trashcan
sleep 60

kubectl delete -f postgres-db-tc.yaml -n trashcan
sleep 3

kubectl delete -f trashcan-sc.yaml
sleep 5
kubectl delete ns trashcan
sleep 5    

kubectl delete -f recoverpv.yaml
sleep 10

VolId=$(kubectl exec $PX_POD -n kube-system -- /opt/pwx/bin/pxctl v l | grep "pvc-restoredvol" | awk '{print $1}' )
kubectl exec $PX_POD -n kube-system -- /opt/pwx/bin/pxctl v d $VolId --force

rm recoverpv.yaml

echo "Cleanup done!"
