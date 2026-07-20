resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "87.2.1"

  namespace        = kubernetes_namespace.deploysafe.metadata[0].name
  create_namespace = false

  values = [
    file("${path.module}/../monitoring/values.yaml")
  ]

  wait    = true
  timeout = 900
}