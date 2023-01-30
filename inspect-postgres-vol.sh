#!/bin/sh

VOL=`kubectl get pvc -n demo | grep postgres-data | awk '{print $3}'`
PX_POD=$(kubectl get pods -l name=portworx -n kube-system -o jsonpath='{.items[0].metadata.name}')
kubectl exec -it $PX_POD -n kube-system -c portworx -- /opt/pwx/bin/pxctl volume inspect ${VOL}


