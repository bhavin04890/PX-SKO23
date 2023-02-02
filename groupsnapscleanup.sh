#!/bin/sh

kubectl delete -f cassandra-app.yaml -n groupsnaps
sleep 30

kubectl delete -f cassandra-groupsnapshot.yaml -n groupsnaps
sleep 30

kubectl delete pvc --all -n groupsnaps
sleep 30

kubectl get all -n groupsnaps

kubectl get pvc -n groupsnaps

kubectl get groupvolumesnapshots -n groupsnaps

kubectl get volumesnapshotdatas.volumesnapshot.external-storage.k8s.io -n groupsnaps

rm restoregrouppvc.yaml

kubectl delete -f group-sc.yaml

kubectl delete ns groupsnaps
