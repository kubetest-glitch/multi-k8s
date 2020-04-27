docker build -t davidzadrazil/multi-client:latest -t davidzadrazil/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t davidzadrazil/multi-server:latest -t davidzadrazil/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t davidzadrazil/multi-worker:latest -t davidzadrazil/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push davidzadrazil/multi-client:latest
docker push davidzadrazil/multi-server:latest
docker push davidzadrazil/multi-worker:latest

docker push davidzadrazil/multi-client:$SHA
docker push davidzadrazil/multi-server:$SHA
docker push davidzadrazil/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=davidzadrazil/multi-server:$SHA
kubectl set image deployments/client-deployment client=davidzadrazil/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=davidzadrazil/multi-worker:$SHA