variable "env" {}
variable "cidr" {}
variable "azs" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
