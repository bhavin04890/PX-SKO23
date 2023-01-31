#!/bin/sh

echo "vps demo" 

#echo "node 1 zone" 
#kubectl get nodes -o=jsonpath='{.items[0].metadata.labels}' | grep "failure-domain.beta.kubernetes.io/zone"

#echo "\n"
#echo "node 2 zone" 
#kubectl get nodes -o=jsonpath='{.items[1].metadata.labels}' | grep "failure-domain.beta.kubernetes.io/zone"

#echo "\n"
#echo "node 3 zone" 
#kubectl get nodes -o=jsonpath='{.items[2].metadata.labels}' | grep "failure-domain.beta.kubernetes.io/zone"

kubectl create ns vps

kubectl apply -f px-repl1-sc.yaml
sleep 5

echo "Stateful Set Affinity VPS:"
cat sts-affinity-vps.yaml

kubectl apply -f sts-affinity-vps.yaml -n vps
sleep 10

kubectl apply -f mongodb-sts.yaml -n vps
sleep 5
