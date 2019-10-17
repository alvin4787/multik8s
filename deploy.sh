docker build -t alvinpaul4787/multi-client:latest -t alvinpaul4787/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alvinpaul4787/multi-server:latest -t alvinpaul4787/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alvinpaul4787/multi-worker:latest -t alvinpaul4787/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push alvinpaul4787/multi-client:latest
docker push alvinpaul4787/multi-server:latest
docker push alvinpaul4787/multi-worker:latest

docker push alvinpaul4787/multi-client:$SHA
docker push alvinpaul4787/multi-server:$SHA
docker push alvinpaul4787/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alvinpaul4787/multi-server:$SHA
kubectl set image deployments/client-deployment client=alvinpaul4787/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alvinpaul4787/multi-worker:$SHA
