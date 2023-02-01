#!/bin/sh

kubectl delete -f cassandra-app.yaml -n groupsnaps
kubectl delete pvc --all -n groupsnaps 

SNAP0=$(kubectl get volumesnapshotdatas.volumesnapshot.external-storage.k8s.io -n groupsnaps -o jsonpath='{.items[0].metadata.name}')
SNAP1=$(kubectl get volumesnapshotdatas.volumesnapshot.external-storage.k8s.io -n groupsnaps -o jsonpath='{.items[1].metadata.name}')

cat << EOF > restoregrouppvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: cassandra-data-cassandra-0
  annotations:
    snapshot.alpha.kubernetes.io/snapshot: $SNAP0
spec:
  accessModes:
     - ReadWriteOnce
  storageClassName: stork-snapshot-sc
  resources:
    requests:
      storage: 2Gi
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: cassandra-data-cassandra-1
  annotations:
    snapshot.alpha.kubernetes.io/snapshot: $SNAP1
spec:
  accessModes:
     - ReadWriteOnce
  storageClassName: stork-snapshot-sc
  resources:
    requests:
      storage: 2Gi
EOF

#cat restoregrouppvc.yaml

kubectl apply -f restoregrouppvc.yaml -n groupsnaps
sleep 10 

kubectl apply -f cassandra-restore-app.yaml -n groupsnaps
