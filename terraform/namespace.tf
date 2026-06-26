resource "kubernetes_namespace" "deploysafe" {
  metadata {
    name = var.namespace
  }
}