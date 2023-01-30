#!/bin/bash

echo "Cleaning up the AWS Immersion Day labs" 

if [ ! -f ~/usr/local/bin/eksctl ]; then
	curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
	sudo cp /tmp/eksctl /usr/local/bin
fi

if [ ! -f ~/usr/local/bin/kubectl ]; then
	curl --silent -LO https://dl.k8s.io/release/v1.21.0/bin/linux/amd64/kubectl
	chmod +x kubectl
	sudo cp ./kubectl /usr/local/bin/
	export PATH=$PATH:/usr/local/bin/
fi

echo "Deleting the destination cluster"
eksctl utils write-kubeconfig --cluster px-destination -r us-west-2
kubectl delete -f dataprotection/k8s-logo.yaml -n demo
sleep 30
kubectl delete -f dataprotection/postgres.yaml -n demo 
sleep 15
kubectl delete ns demo
kubectl delete deploy stork -n kube-system 
sleep 15 
eksctl delete cluster -f eks-destination-cluster.yaml
sleep 10
 
eksctl utils write-kubeconfig --cluster px-source -r us-west-2

kubectl delete ns -n rabbitmq-demo
kubectl delete ns zookeeper-demo
kubectl delete ns kafka-demo
kubectl delete ns mysql-demo

kubectl delete ns postgres-demo
kubectl delete ns cassandra-demo 
sudo yum install openssl -y
sleep 5
sudo curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
sleep 10

helm uninstall pds -n pds-system
kubectl delete stc --all -n kube-system

eksctl delete cluster -f eks-source-cluster.yaml


