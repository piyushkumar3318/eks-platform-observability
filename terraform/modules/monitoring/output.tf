output "prometheus_release" {
  value = helm_release.prometheus.name
}

output "grafana_release" {
  value = helm_release.grafana.name
}

output "daemonset_name" {
  value = kubernetes_daemon_set_v1.node_agent.metadata[0].name
}
