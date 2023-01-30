#!/bin/sh

kubectl create ns jenkins 
sleep 10 

kubectl apply -f jenkins-pvc.yaml -n jenkins
sleep 10

helm repo add jenkins https://charts.jenkins.io
helm repo update
sleep 10 

helm install jenkins jenkins/jenkins --set rbac.create=true,controller.servicePort=80,controller.serviceType=LoadBalancer,persistence.existingClaim=jenkins-claim -n jenkins
sleep 60 

kubectl patch statefulsets jenkins -p '{"spec":{"replicas":3}}' -n jenkins
sleep 10

echo "Jenkins Endpoint:" 
kubectl get svc --namespace jenkins jenkins 

echo "Jenkins Username:"
echo "admin" 
echo "Jenkins Password:" 
kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo


