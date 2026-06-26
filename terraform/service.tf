resource "kubernetes_service" "deploysafe" {

  metadata {
    name      = "deploysafe-service"
    namespace = kubernetes_namespace.deploysafe.metadata[0].name
  }

  spec {

    type = var.service_type

    selector = {
      app = var.app_name
    }

    port {
      port        = 80
      target_port = 8000
    }
  }
}