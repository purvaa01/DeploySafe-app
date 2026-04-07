#!/bin/bash

set -e

echo "Adding Helm repo..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

echo "Updating Helm repos..."
helm repo update

echo "Installing Prometheus + Grafana stack..."
helm upgrade --install monitoring prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace

echo "Monitoring stack deployed successfully!"