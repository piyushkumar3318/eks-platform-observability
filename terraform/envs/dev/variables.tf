variable "region" {
  default = "us-west-2"
}

variable "cluster_role_arn" {
  description = "IAM role for EKS control plane"
}

variable "node_role_arn" {
  description = "IAM role for worker nodes"
}
