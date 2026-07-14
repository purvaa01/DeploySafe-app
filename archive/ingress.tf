resource "kubernetes_ingress_v1" "deploysafe" {

  metadata {
    name      = "deploysafe-ingress"
    namespace = kubernetes_namespace.deploysafe.metadata[0].name
  }

  spec {

    ingress_class_name = "nginx"

    rule {

      host = var.ingress_host

      http {

        path {

          path      = "/"
          path_type = "Prefix"

          backend {

            service {

              name = kubernetes_service.deploysafe.metadata[0].name

              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}