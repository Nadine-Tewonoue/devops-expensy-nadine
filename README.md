# Expensy - Cloud Native Expense Tracker

Expensy is a cloud-native expense tracking application deployed on **Azure Kubernetes Service (AKS)**.  
The project demonstrates **containerization, Kubernetes orchestration, monitoring, and cloud infrastructure deployment**.

The application consists of a **Next.js frontend**, **Node.js backend**, **MongoDB database**, and a **monitoring stack with Prometheus and Grafana**.

---

## Project Architecture

The system is deployed using **Kubernetes microservices architecture**.

Main components:

- Frontend (Next.js)
- Backend API (Node.js)
- MongoDB database
- Redis cache
- Kubernetes Ingress Controller
- Prometheus monitoring
- Grafana dashboards

Users access the application through a custom domain:
http://djota.azure.diogohack.shop


Traffic flow:

User → Ingress → Kubernetes Services → Application Pods

---

## Project Structure
.
├── apply-yaml.sh
├── create-aks-cluster.sh
├── docker-compose.yml
├── docker.sh
├── expensy_backend
├── expensy_frontend
├── helm
├── k8s
└── stop-azure.sh

### Key Directories

**expensy_frontend**

Contains the Next.js frontend application.

**expensy_backend**

Contains the Node.js backend API.

**k8s**

Kubernetes manifests including:

- deployments
- services
- ingress
- secrets
- persistent volumes

**helm**

Helm chart used to deploy the application.

---

## Technologies Used

- Docker
- Kubernetes
- Azure Kubernetes Service (AKS)
- Node.js
- Next.js
- MongoDB
- Redis
- Prometheus
- Grafana
- Helm

---

## Deployment Steps

### 1 Create Azure Kubernetes Cluster

Run the script:

```bash
./create-aks-cluster.sh

2 Build Docker Images
./docker.sh
3 Deploy Kubernetes Resources
./apply-yaml.sh
4 Verify Pods
kubectl get pods -n expensy
5 Access Application

Open:


http://djota.azure.diogohack.shop

Monitoring

The project includes a monitoring stack:

Prometheus

Collects metrics from Kubernetes nodes and services.

Example query:


up

Grafana

Used for visualizing Prometheus metrics through dashboards.

Challenges Faced
Monitoring

The project includes a monitoring stack:

Prometheus

Collects metrics from Kubernetes nodes and services.

Example query:


up

Grafana

Used for visualizing Prometheus metrics through dashboards.

Challenges Faced

Some challenges encountered during development:

Configuring Kubernetes Ingress and Load Balancer

Managing persistent storage for MongoDB

Setting up monitoring with Prometheus and Grafana

Debugging Kubernetes pods and networking

Managing secrets securely

Future Improvements

Possible improvements for the project:

Implement CI/CD pipeline

Add authentication and authorization

Improve autoscaling with HPA

Use managed cloud databases

Author

Nadine

Cloud Native / DevOps Project