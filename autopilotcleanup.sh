#!/bin/sh

echo "cleaning up autopilot"
kubectl delete -f autopilot-app.yaml -n pg1
sleep 30
kubectl delete -f autopilot-postgres.yaml -n pg1
sleep 30
kubectl delete -f namespaces.yaml
sleep 30
