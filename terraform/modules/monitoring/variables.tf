variable "namespace" {
  description = "Namespace for monitoring resources"
  type        = string
  default     = "monitoring"
}

variable "prometheus_release_name" {
  description = "Release name for Prometheus"
  type        = string
  default     = "prometheus"
}

variable "grafana_release_name" {
  description = "Release name for Grafana"
  type        = string
  default     = "grafana"
}

variable "daemonset_name" {
  description = "Name of the DaemonSet for node-level logging"
  type        = string
  default     = "node-agent"
}
