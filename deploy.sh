docker build -t aghabekyan374/multi-client:latest -t aghabekyan374/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aghabekyan374/multi-server:latest -t aghabekyan374/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aghabekyan374/multi-worker:latest -t aghabekyan374/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Take those Images and push them to docker hub
docker push aghabekyan374/multi-client:latest
docker push aghabekyan374/multi-server:latest
docker push aghabekyan374/multi-worker:latest

docker push aghabekyan374/multi-client:$SHA
docker push aghabekyan374/multi-server:$SHA
docker push aghabekyan374/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aghabekyan374/multi-server:$SHA
kubectl set image deployments/client-deployment client=aghabekyan374/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aghabekyan374/multi-worker:$SHA
