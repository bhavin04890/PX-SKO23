#/bin/sh

kubectl delete -f dataprotection/mongo-service.yaml -n pacman
sleep 30
kubectl delete -f dataprotection/pacman-service.yaml -n pacman
sleep 30
kubectl delete -f dataprotection/mongo-deployment.yaml -n pacman
sleep 10
kubectl delete -f dataprotection/mongo-pvc.yaml -n pacman
sleep 10
kubectl delete -f dataprotection/pacman-deployment.yaml -n pacman
sleep 10
kubectl delete ns pacman
sleep 30

echo "Pacman delete 'Accidently'"
