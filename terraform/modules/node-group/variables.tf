variable "env" {}
variable "cluster_name" {}
variable "node_role_arn" {}
variable "subnet_ids" {
  type = list(string)
}
variable "instance_types" {
  type = list(string)
}
variable "capacity_type" {}
variable "desired_size" {}
variable "min_size" {}
variable "max_size" {}
