docker build -t wolfgangbecker/multi-client:latest -t wolfgangbecker/multi-client:latest:$SHA -f ./client/Dockerfile ./client
docker build -t wolfgangbecker/multi-server:latest -t wolfgangbecker/multi-server:latest:$SHA -f ./server/Dockerfile ./server
docker build -t wolfgangbecker/multi-worker:latest -t wolfgangbecker/multi-worker:latest:$SHA -f ./worker/Dockerfile ./worker

docker push wolfgangbecker/multi-client:latest
docker push wolfgangbecker/multi-server:latest
docker push wolfgangbecker/multi-worker:latest

docker push wolfgangbecker/multi-client:$SHA
docker push wolfgangbecker/multi-server:$SHA
docker push wolfgangbecker/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=wolfgangbecker/multi-client:$SHA
kubectl set image deployments/server-deployment server=wolfgangbecker/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=wolfgangbecker/multi-worker:$SHA
