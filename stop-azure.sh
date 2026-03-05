#!/bin/bash
# stop-azure-resources.sh

set -e

echo "Stopping all major compute resources in Azure..."

# 1️⃣ Scale AKS node pools to 0
AKS_RG="rg-monitoring-lab.nadine"
AKS_NAME="aks-devops-expensy"

echo "Scaling AKS cluster '$AKS_NAME' node pools to 0..."
az aks scale \
    --resource-group "$AKS_RG" \
    --name "$AKS_NAME" \
    --node-count 0 \
    --no-wait

# 2️⃣ Deallocate VM scale sets
VMSS_RG="MC_rg-monitoring-lab.nadine_aks-devops-expensy_westeurope"
VMSS_NAME="aks-nodepool1-85060930-vmss"

echo "Deallocating VM scale set '$VMSS_NAME'..."
az vmss deallocate \
    --resource-group "$VMSS_RG" \
    --name "$VMSS_NAME" \
    --no-wait

echo "✅ Major compute resources are stopping/deallocating."
echo "Grafana and other resources do not need to be stopped."