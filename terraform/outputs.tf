output "namespace" {
  description = "DeploySafe namespace"
  value       = kubernetes_namespace.deploysafe.metadata[0].name
}

output "deployment_name" {
  description = "Deployment name"
  value       = kubernetes_deployment.deploysafe.metadata[0].name
}

output "service_name" {
  description = "Service name"
  value       = kubernetes_service.deploysafe.metadata[0].name
}

output "ingress_host" {
  description = "Ingress hostname"
  value       = var.ingress_host
}

output "grafana_release" {
  description = "Grafana/Prometheus Helm release"
  value       = helm_release.prometheus.name
}