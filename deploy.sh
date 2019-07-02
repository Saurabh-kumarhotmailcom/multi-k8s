docker build -t saurabhkumardocker/multi-client:latest -t saurabhkumardocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t saurabhkumardocker/multi-server:latest -t saurabhkumardocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t saurabhkumardocker/multi-worker:latest -t saurabhkumardocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push saurabhkumardocker/multi-client:latest
docker push saurabhkumardocker/multi-server:latest
docker push saurabhkumardocker/multi-worker:latest

docker push saurabhkumardocker/multi-client:$SHA
docker push saurabhkumardocker/multi-server:$SHA
docker push saurabhkumardocker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=saurabhkumardocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=saurabhkumardocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=saurabhkumardocker/multi-worker:$SHA