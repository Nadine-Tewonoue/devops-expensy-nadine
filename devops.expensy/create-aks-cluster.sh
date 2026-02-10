#!/usr/bin/env bash

set -e

# ===== VARIABLES =====
RESOURCE_GROUP="rg-monitoring-lab.nadine"
AKS_NAME="aks-devops-expensy"
LOCATION="westeurope"
NODE_COUNT=1
NODE_VM_SIZE="Standard_D2s_v3"

# ===== LOGIN CHECK =====
echo "Checking Azure login..."
az account show >/dev/null 2>&1 || az login

# ===== CREATE RESOURCE GROUP (if not exists) =====
echo "Ensuring resource group exists..."
az group create \
  --name "$RESOURCE_GROUP" \
  --location "$LOCATION"

# ===== CREATE AKS CLUSTER =====
echo "Creating AKS cluster..."
az aks create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$AKS_NAME" \
  --node-count "$NODE_COUNT" \
  --node-vm-size "$NODE_VM_SIZE" \
  --enable-managed-identity \
  --generate-ssh-keys \
  --location "$LOCATION"

# ===== GET KUBECONFIG =====
echo "Fetching kubeconfig..."
az aks get-credentials \
  --resource-group "$RESOURCE_GROUP" \
  --name "$AKS_NAME"

echo "✅ AKS cluster '$AKS_NAME' created successfully!"

