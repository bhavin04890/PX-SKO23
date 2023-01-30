#!/bin/bash

echo "Wrapping up Data Protection section" 

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

echo "Deleting demo applications on destination cluster"
eksctl utils write-kubeconfig --cluster px-destination -r us-west-2
kubectl delete -f dataprotection/k8s-logo.yaml -n demo
sleep 30
kubectl delete -f dataprotection/postgres.yaml -n demo 
sleep 15
kubectl delete ns demo
#kubectl delete deploy stork -n kube-system 
#sleep 15 
#eksctl delete cluster -f eks-destination-cluster.yaml

echo "Deleting demo applications on source cluster" 
eksctl utils write-kubeconfig --cluster px-source -r us-west-2
#kubectl delete -f dataprotection/k8s-logo.yaml -n demo
#sleep 30
#kubectl delete -f dataprotection/postgres.yaml -n demo 
#sleep 15
kubectl delete ns demo
sleep 5
kubectl delete deploy stork -n kube-system 
sleep 15 
kubectl delete -f dataprotection/mongo-service.yaml -n pacman
sleep 15 
kubectl delete -f dataprotection/pacman-service.yaml -n pacman 
sleep 15
kubectl delete -f dataprotection/mongo-deployment.yaml -n pacman
sleep 15 
kubectl delete -f dataprotection/pacman-deployment.yaml -n pacman
sleep 15 
kubectl delete -f dataprotection/mongo-pvc.yaml -n pacman
sleep 15
kubectl delete ns pacman
#eksctl delete cluster -f eks-source-cluster.yaml

#echo "Deleting Backup buckets"

#REGL_BUCKET="pxbackup-demo"
#aws s3 rm s3://$REGL_BUCKET --r us-west-2 --recursive
#aws s3 rb s3://$REGL_BUCKET --r us-west-2

echo "Installing Helm"
sudo yum install openssl -y
sleep 5
sudo curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
sleep 10

