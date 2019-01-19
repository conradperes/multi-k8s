docker build -t conradperes/multi-client:latest -t conradperes/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t conradperes/multi-server:latest -t conradperes/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t conradperes/multi-worker:latest -t conradperes/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push conradperes/multi-client:latest
docker push conradperes/multi-server:latest
docker push conradperes/multi-worker:latest

docker push conradperes/multi-client:$SHA
docker push conradperes/multi-server:$SHA
docker push conradperes/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=conradperes/multi-server$SHA
kubectl set image deployments/client-deploymet client=conradperes/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=conradperes/multi-worker:$SHA
