#!/bin/sh

# See where postgres is running
kubectl get po -n demo -l app=postgres -o wide

# Get the postgres node name
NODE=`kubectl get pods -n demo -l app=postgres -o wide | grep -v NAME | awk '{print $7}'`

# Cordon the node (apps are no longer allowed on this node)
kubectl cordon ${NODE}

# Get the postgres pod node
POD=$(kubectl get pods -n demo -l app=postgres -o wide | grep -v NAME | awk '{print $1}')

# Delete the pod
kubectl delete pod ${POD} -n demo

# See what node postgres is running on now that its been deleted
kubectl get po -n demo -l app=postgres -o wide

