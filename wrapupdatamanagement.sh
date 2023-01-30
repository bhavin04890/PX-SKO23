#!/bin/bash

echo "Wrapping up Data Management section" 

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

echo "Deleting demo applications on source cluster" 
eksctl utils write-kubeconfig --cluster px-source -r us-west-2

kubectl delete deploy --all -n demo
sleep 5 
kubectl delete pvc --all -n demo
sleep 5
kubectl delete svc --all -n demo
sleep 5
kubectl delete stork-volumesnapshots --all -n demo
sleep 5
kubectl delete ns demo
sleep 10 

helm uninstall jenkins -n jenkins 
sleep 10

kubectl delete pods --all
sleep 5 
kubectl delete pvc --all 
sleep 5

kubectl delete deploy pgbench -n pg1
sleep 5 
kubectl delete pvc --all -n pg1
sleep 5 
kubectl delete ns pg1
sleep 10
