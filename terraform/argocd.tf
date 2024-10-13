locals {
  argocd_resources_labels = {
    "app.kubernetes.io/instance"  = "argocd"
    "argocd.argoproj.io/instance" = "argocd"
  }

  argocd_resources_annotations = {
    "argocd.argoproj.io/compare-options" = "IgnoreExtraneous"
    "argocd.argoproj.io/sync-options"    = "Prune=false,Delete=false"
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}


resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.6.8"

  namespace = "argocd"

  create_namespace = true

  set {
    name  = "server.service.type"
    value = "NodePort"
  }

  #   set {
  #     name  = "server.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
  #     value = "nlb"
  #   }
}
