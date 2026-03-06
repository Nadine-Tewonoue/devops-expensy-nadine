xpensy Monitoring Stack
Project Overview

This project deploys a full monitoring and dashboard stack on Kubernetes using:

Prometheus – metrics collection

Node Exporter – node-level metrics

Grafana – visualization dashboards

Backend & Frontend – application services

Redis & MongoDB – supporting services

It uses a custom domain (djota.azure.diogohack.shop) via Azure DNS to expose services through an Ingress.

Architecture
[ Users ] -> [ Ingress / djota.azure.diogohack.shop ] -> [ Frontend / Grafana / Prometheus ]
                                                      \
                                                       -> [ Backend ]
                                                       -> [ Node Exporter ]
                                                       -> [ Redis / MongoDB ]

Grafana dashboards visualize application metrics.

Prometheus scrapes metrics from backend, node-exporter, and Prometheus itself.

Node Exporter exposes node-level metrics.

Ingress routes traffic to services under djota.azure.diogohack.shop.

Prerequisites

Azure Kubernetes Service (AKS) cluster

kubectl configured for your cluster

Optional: Helm (for cert-manager / TLS)

DuckDNS / Azure DNS domain pointing to cluster IP

Setup Steps
1. Deploy Core Services
kubectl apply -f mongo.yaml
kubectl apply -f redis.yaml
kubectl apply -f backend.yaml
kubectl apply -f frontend.yaml
2. Deploy Prometheus
kubectl apply -f prometheus.yaml

Ensure only one Prometheus pod is running:

kubectl get pods -n expensy
3. Deploy Node Exporter
kubectl apply -f node-exporter.yaml

Node Exporter is a DaemonSet. Check pods:

kubectl get pods -n expensy -l app=node-exporter
4. Deploy Grafana
kubectl apply -f grafana.yaml

Reset admin password (if needed):

kubectl exec -n expensy $(kubectl get pods -n expensy -l app=grafana -o jsonpath="{.items[0].metadata.name}") -- grafana-cli admin reset-admin-password admin123
5. Setup Azure DNS

Go to your Azure DNS Zone: azure.diogohack.shop

Create a record set:

Name: djota

Type: A

Value: Your LoadBalancer public IP (kubectl get svc -n expensy frontend)

Wait for DNS propagation (usually a few minutes).

6. Configure Ingress

Example ingress.yaml:

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: expensy-ingress
  namespace: expensy
  annotations:
    kubernetes.io/ingress.class: nginx
spec:
  rules:
    - host: djota.azure.diogohack.shop
      http:
        paths:
          - path: /grafana
            pathType: Prefix
            backend:
              service:
                name: grafana
                port:
                  number: 3000
          - path: /prometheus
            pathType: Prefix
            backend:
              service:
                name: prometheus
                port:
                  number: 9090
          - path: /
            pathType: Prefix
            backend:
              service:
                name: frontend
                port:
                  number: 80

Apply it:

kubectl apply -f ingress.yaml

Access in browser:

http://djota.azure.diogohack.shop/ → frontend

http://djota.azure.diogohack.shop/grafana → Grafana

http://djota.azure.diogohack.shop/prometheus → Prometheus

Verification

Prometheus metrics:

kubectl port-forward svc/prometheus 9090:9090 -n expensy

Visit: http://localhost:9090/targets

Grafana dashboards:

Node Exporter Full

Application metrics dashboards

Node Exporter:

Ensure pods are running on all nodes:

kubectl get pods -n expensy -l app=node-exporter
Optional: Enable HTTPS

Install cert-manager

Update Ingress annotations for TLS using your DuckDNS / Azure DNS domain

Troubleshooting

No data in Grafana?

Check Prometheus targets: http://djota.azure.diogohack.shop:9090/targets

Verify Node Exporter pods are running

Prometheus pod crash → ensure single replica and PVC is available

Ingress 404 errors → check:

kubectl describe ingress expensy-ingress -n expensy