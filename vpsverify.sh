#!/bin/sh

#echo "vps demo" 

MONGO0PVC1=$(kubectl get pvc -n vps -o jsonpath='{.items[0].spec.volumeName}')
MONGO0PVC2=$(kubectl get pvc -n vps -o jsonpath='{.items[2].spec.volumeName}')

MONGO1PVC1=$(kubectl get pvc -n vps -o jsonpath='{.items[1].spec.volumeName}')
MONGO1PVC2=$(kubectl get pvc -n vps -o jsonpath='{.items[3].spec.volumeName}')

#echo $MONGO0PVC1
#echo $MONGO0PVC2
#echo $MONGO1PVC1
#echo $MONGO1PVC2

echo "PVCs for the MongoDB STS"
kubectl get pvc -n vps

PX_POD=$(kubectl get pods -l name=portworx -n kube-system -o jsonpath='{.items[0].metadata.name}')

echo "PVC 1 for mongo-0: $MONGO0PVC1 "
kubectl exec $PX_POD -n kube-system -c portworx -- /opt/pwx/bin/pxctl v i $MONGO0PVC1 | grep Node
echo "\n"
echo "PVC 2 for mongo-0: $MONGO0PVC2"
kubectl exec $PX_POD -n kube-system -c portworx -- /opt/pwx/bin/pxctl v i $MONGO0PVC2 | grep Node
echo "\n"
echo "PVC 1 for mongo-1: $MONGO1PVC1"
kubectl exec $PX_POD -n kube-system -c portworx -- /opt/pwx/bin/pxctl v i $MONGO1PVC1 | grep Node
echo "\n"
echo "PVC 2 for mongo-1: $MONGO1PVC2"
kubectl exec $PX_POD -n kube-system -c portworx -- /opt/pwx/bin/pxctl v i $MONGO1PVC2 | grep Node





