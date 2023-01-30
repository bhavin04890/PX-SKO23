#!/bin/sh

echo "Deleting App"
kubectl delete -f postgres-db-tc.yaml -n trashcan
sleep 30

echo "Restoring volume from Portworx Trashcan"
PX_POD=$(kubectl get pods -l name=portworx -n kube-system -o jsonpath='{.items[0].metadata.name}')
VolName=$(kubectl exec $PX_POD -n kube-system -- /opt/pwx/bin/pxctl volume list --trashcan | grep "25 GiB" | awk '{print $8}' )

kubectl exec $PX_POD -n kube-system -- /opt/pwx/bin/pxctl v restore --trashcan $VolName pvc-restoredvol
VolId=$(kubectl exec $PX_POD -n kube-system -- /opt/pwx/bin/pxctl v l | grep "pvc-restoredvol" | awk '{print $1}' )

cat << EOF > recoverpv.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  annotations: 
    pv.kubernetes.io/provisioned-by: kubernetes.io/portworx-volume
  finalizers: 
  - kubernetes.io/pv-protection
  name: pvc-restoredvol
spec:
  capacity:
    storage: 25Gi
  claimRef:
    apiVersion: v1
    kind: PersistentVolumeClaim
    name: postgres-data
    namespace: trashcan
  accessModes:
    - ReadWriteOnce
  storageClassName: trash-sc
  persistentVolumeReclaimPolicy: Retain
  portworxVolume:
    volumeID: "$VolId"
EOF

echo "Creating a new PV from the restored portworx volume"

kubectl apply -f recoverpvtest.yaml

echo "Redeploying the Postgres Pod and PVC"
kubectl apply -f postgres-db-tc.yaml -n trashcan
sleep 10
kubectl delete deploy k8s-counter-deployment -n trashcan
sleep 30
kubectl apply -f k8s-webapp-tc.yaml -n trashcan 
sleep 30

echo "Application Endpoint:"
kubectl get svc -n trashcan

