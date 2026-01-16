variable "env" {}
variable "cluster_name" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "cluster_role_arn" {
  description = "IAM role ARN for EKS cluster"
}