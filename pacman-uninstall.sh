#!/bin/bash

kubectl delete -n pacman -f dataprotection/rbac.yaml
kubectl delete -n pacman -f dataprotection/secret.yaml
kubectl delete -n pacman -f dataprotection/mongo-deployment.yaml
kubectl delete -n pacman -f dataprotection/pacman-deployment.yaml
kubectl delete -n pacman -f dataprotection/mongo-service.yaml
kubectl delete -n pacman -f dataprotection/pacman-service.yaml
kubectl delete -n pacman -f dataprotection/mongo-pvc.yaml

