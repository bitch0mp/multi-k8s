docker build -t bitch0mp/multi-client-k8s:latest -t bitch0mp/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t bitch0mp/multi-server-k8s:latest -t bitch0mp/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t bitch0mp/multi-worker-k8s:latest -t bitch0mp/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push bitch0mp/multi-client-k8s:latest
docker push bitch0mp/multi-server-k8s:latest
docker push bitch0mp/multi-worker-k8s:latest

docker push bitch0mp/multi-client-k8s:$SHA
docker push bitch0mp/multi-server-k8s:$SHA
docker push bitch0mp/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bitch0mp/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=bitch0mp/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=bitch0mp/multi-worker-k8s:$SHA