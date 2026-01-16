variable "region" {
  description = "AWS region for production"
}

variable "cluster_role_arn" {
  description = "IAM role for EKS control plane"
}

variable "node_role_arn" {
  description = "IAM role for worker nodes"
}
