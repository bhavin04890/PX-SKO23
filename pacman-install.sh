#!/bin/sh

kubectl create namespace pacman
kubectl create -n pacman -f dataprotection/rbac.yaml
kubectl create -n pacman -f dataprotection/secret.yaml
kubectl create -n pacman -f dataprotection/mongo-pvc.yaml
kubectl create -n pacman -f dataprotection/mongo-deployment.yaml
while [ "$(kubectl get pods -l=name='mongo' -n pacman -o jsonpath='{.items[*].status.containerStatuses[0].ready}')" != "true" ]; do
   sleep 5
   echo "Waiting for mongo pod to change to running status"
done
kubectl create -n pacman -f dataprotection/pacman-deployment.yaml
kubectl create -n pacman -f dataprotection/mongo-service.yaml
kubectl create -n pacman -f dataprotection/pacman-service.yaml
