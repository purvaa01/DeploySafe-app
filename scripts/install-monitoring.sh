#!/bin/bash

set -e

echo "Creating monitoring namespace..."
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

echo "Adding Helm repo..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts || true

echo "Updating Helm repos..."
helm repo update

echo "Installing/Upgrading Prometheus + Grafana..."
helm upgrade --install monitoring prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace \
  --wait

echo "Monitoring stack deployed successfully!"

echo "Current monitoring pods:"
kubectl get pods -n monitoring