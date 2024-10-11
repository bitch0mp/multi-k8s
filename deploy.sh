docker build -t bitch0mp/multi-client:latest -t bitch0mp/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bitch0mp/multi-server:latest -t bitch0mp/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bitch0mp/multi-worker:latest -t bitch0mp/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bitch0mp/multi-client:latest
docker push bitch0mp/multi-server:latest
docker push bitch0mp/multi-worker:latest

docker push bitch0mp/multi-client:$SHA
docker push bitch0mp/multi-server:$SHA
docker push bitch0mp/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=bitch0mp/multi-server:$SHA
kubectl set image deployments/client-deployment client=bitch0mp/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bitch0mp/multi-worker:$SHA