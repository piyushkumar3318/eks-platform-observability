# Namespace
resource "kubernetes_namespace_v1" "monitoring" {
  metadata {
    name = var.namespace
  }
}

# DaemonSet
resource "kubernetes_daemon_set_v1" "node_agent" {
  metadata {
    name      = var.daemonset_name
    namespace = kubernetes_namespace_v1.monitoring.metadata[0].name
    labels = {
      app = var.daemonset_name
    }
  }

  spec {
    selector {
      match_labels = {
        app = var.daemonset_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.daemonset_name
        }
      }

      spec {
        container {
          name  = var.daemonset_name
          image = "docker.elastic.co/beats/filebeat:8.11.1"

          volume_mount {
            name       = "varlog"
            mount_path = "/var/log"
          }
        }

        volume {
          name = "varlog"
          host_path {
            path = "/var/log"
          }
        }
      }
    }
  }
}
