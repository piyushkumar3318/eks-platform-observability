


# Prometheus
resource "helm_release" "prometheus" {
  name             = var.prometheus_release_name
  namespace        = var.namespace
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = "50.0.1"
  create_namespace = true
}

# Grafana
resource "helm_release" "grafana" {
  name             = var.grafana_release_name
  namespace        = var.namespace
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  version          = "6.17.6"
  create_namespace = true
}
