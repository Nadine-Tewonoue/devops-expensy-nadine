Expensy Monitoring Stack

Expensy is a full-stack application deployed on Azure Kubernetes Service (AKS), with integrated monitoring using Prometheus and Grafana. This project contains the backend, frontend, and all Kubernetes manifests required to deploy the stack.

Project Structure
.
├── k8s/                     # Kubernetes manifests
├── helm/expensy/            # Helm charts (optional)
├── expensy_backend/         # Backend Node.js app
├── expensy_frontend/        # Frontend Next.js app
├── docker-compose.yml       # Local development with Docker
├── create-aks-cluster.sh    # Script to provision AKS
├── apply-yaml.sh            # Script to deploy Kubernetes resources
└── stop-azure.sh            # Script to clean up Azure resources
Prerequisites

Azure CLI installed and logged in

kubectl installed

Helm (optional, if you use Helm charts)

Docker for building local images

A DuckDNS / custom domain pointing to your cluster’s public IP

Deployment Steps
1. Create an AKS Cluster
./create-aks-cluster.sh --resource-group <RG_NAME> --lb-name <LB_NAME> --output <OUTPUT_FILE>
2. Apply Kubernetes Manifests
./apply-yaml.sh

This will deploy:

Backend: Node.js API

Frontend: Next.js app

MongoDB & Redis

Prometheus + Grafana

Node Exporter for monitoring

Ingress with your custom domain

3. Configure Domain

Use your DuckDNS or Azure DNS to point a subdomain to your cluster ingress IP.

Example: djota.azure.diogohack.shop → <INGRESS_PUBLIC_IP>

Update all ingress manifests to use your custom domain instead of .nip.io.

Accessing Services
Service	Type	URL / Port
Frontend	LoadBalancer	http://djota.azure.diogohack.shop

Backend	ClusterIP	internal: backend.expensy.svc.cluster.local:8706
Grafana	ClusterIP	internal: grafana.expensy.svc.cluster.local:3000
Prometheus	ClusterIP	internal: prometheus.expensy.svc.cluster.local:9090

Port-forwarding for local access:

kubectl port-forward svc/grafana 3000:3000 -n expensy
kubectl port-forward svc/prometheus 9090:9090 -n expensy
Monitoring
Grafana

Access Grafana at your custom domain or via port-forward.

Login with admin credentials (reset with grafana-cli if needed).

Import dashboards:

Node Exporter

Prometheus metrics

Verify that Node Exporter pods are running:

kubectl get pods -n expensy -l app=node-exporter
Prometheus

Verify targets:

kubectl port-forward svc/prometheus 9090:9090 -n expensy

Open http://localhost:9090/targets to ensure all services are scraped.

Troubleshooting

No data in Grafana

Ensure Node Exporter pods are running.

Ensure Prometheus is scraping the correct endpoints.

Check pod logs:

kubectl logs <prometheus-pod> -n expensy
kubectl logs <node-exporter-pod> -n expensy

Pod stuck in Pending

Check events:

kubectl describe pod <pod-name> -n expensy

Verify node resources, hostPorts, and tolerations.

Dashboard import fails

Check UID conflicts in Grafana and choose “Import (Overwrite)” if needed.

Scripts

create-aks-cluster.sh – Provision AKS cluster

apply-yaml.sh – Deploy manifests to AKS

stop-azure.sh – Cleanup resources in Azure

Notes

Use your custom domain in all ingress and environment variables.

For monitoring, Node Exporter and Prometheus must run one pod per cluster.

Persistent Volumes are used for Grafana and Prometheus data.

