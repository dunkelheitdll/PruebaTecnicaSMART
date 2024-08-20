provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "prueba" {
  metadata {
    name = "prueba-deployment"
    labels = {
      app = "prueba"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "prueba"
      }
    }

    template {
      metadata {
        labels = {
          app = "prueba"
        }
      }

      spec {
        container {
          image = "pruebatecnica.azurecr.io/mi-repo:latest"
          name  = "prueba"
        }
      }
    }
  }
}
