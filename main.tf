provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "app" {
  metadata {
    name = "hello-world-app"
  }
  spec {
    replicas = 2
    template {
      metadata {
        labels = {
          app = "hello-world"
        }
      }
      spec {
        container {
          image = "tu-usuario/hello-world-app:latest"
          name  = "hello-world"
        }
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name = "hello-world-service"
  }
  spec {
    selector = {
      app = "hello-world"
    }
    type = "NodePort"
    port {
      port        = 80
      target_port = 8080
    }
  }
}
