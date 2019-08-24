# Build Docker images
docker build -t synergee/multi-client:latest -t synergee/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t synergee/multi-server:latest -t synergee/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t synergee/multi-worker:latest -t synergee/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Push Docker images to registry
docker push synergee/multi-client:latest
docker push synergee/multi-client:$SHA

docker push synergee/multi-server:latest
docker push synergee/multi-server:$SHA

docker push synergee/multi-worker:latest
docker push synergee/multi-worker:$SHA

# Apply Kubernetes cluster
kubectl apply -f k8s

# Set image implicitly to latest version
kubectl set image deployments/client-deployment client=synergee/multi-client:$SHA
kubectl set image deployments/server-deployment server=synergee/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=synergee/multi-worker:$SHA