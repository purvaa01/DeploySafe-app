resource "kubernetes_deployment" "deploysafe" {

  metadata {
    name      = "deploysafe-deployment"
    namespace = kubernetes_namespace.deploysafe.metadata[0].name

    labels = {
      app = var.app_name
    }
  }

  spec {

    replicas = var.replicas

    strategy {
      type = "RollingUpdate"

      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {

      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {

        container {

          name  = "deploysafe-container"
          image = var.image

          port {
            container_port = 8000
          }

          resources {

            requests = {
              cpu    = "200m"
              memory = "256Mi"
            }

            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
          }

          liveness_probe {

            http_get {
              path = "/health"
              port = 8000
            }

            initial_delay_seconds = 10
            period_seconds        = 10
            timeout_seconds       = 2
            failure_threshold     = 3
          }

          readiness_probe {

            http_get {
              path = "/health"
              port = 8000
            }

            initial_delay_seconds = 5
            period_seconds        = 5
            timeout_seconds       = 2
            failure_threshold     = 3
          }
        }
      }
    }
  }
}