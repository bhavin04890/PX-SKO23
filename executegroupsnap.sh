#!/bin/sh

kubectl apply -f cassandra-groupsnapshot.yaml -n groupsnaps
sleep 10

kubectl get groupvolumesnapshot -n groupsnaps
sleep 10

kubectl describe groupvolumesnapshot cassandra-group-snapshot -n groupsnaps
sleep 5

