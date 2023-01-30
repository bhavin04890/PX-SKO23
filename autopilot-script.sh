#!/bin/sh

kubectl create -f autopilot.yaml
sleep 30 

kubectl create -f autopilotrule.yaml
sleep 10
kubectl create -f namespaces.yaml
sleep 5
kubectl create -f autopilot-postgres.yaml -n pg1
sleep 10
kubectl create -f autopilot-app.yaml -n pg1
sleep 10
