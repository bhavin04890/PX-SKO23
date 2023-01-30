#!/bin/sh

PX_POD=$(kubectl get pods -l name=portworx -n kube-system -o jsonpath='{.items[0].metadata.name}')

VolName=$(kubectl exec $PX_POD -n kube-system -- /opt/pwx/bin/pxctl volume list | grep "47 GiB" | awk '{print $2}' )

kubectl exec $PX_POD -n kube-system -- /opt/pwx/bin/pxctl volume inspect $VolName

kubectl exec $PX_POD -n kube-system -- /opt/pwx/bin/pxctl volume update --max_iops 750,750 $VolName

kubectl exec $PX_POD -n kube-system -- /opt/pwx/bin/pxctl volume inspect $VolName
