
#!/bin/bash
# ==============================================
#Docker Built script for Ironhack project1
# ==============================================

set -e  # Exit immediately on any error
set -o pipefail
# Navigate to the vote app directory and build its image
cd expensy_backend
docker build -t anne2693/expensy_backend .
docker push anne2693/expensy_backend

# Navigate to the result app directory and build its image
cd ../result
docker build -t anne2693/expensy_frontend .
docker push anne2693/expensy_frontend

# Navigate to the worker app directory and build its image
cd ../worker
docker build -t anne2693/worker-app .
docker push anne2693/worker-app


docker network create frontend
docker network create backend

docker run -d --name voting-app --network frontend -p 5000:80 anne2693/voting-app
docker run -d --name redis --network frontend redis:latest
docker run -d --name db --network backend -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres postgres:latest
docker run -d --name worker-app --network frontend --network backend anne2693/worker-app
docker run -d --name result-app --network backend -p 5001:80 anne2693/result-app





