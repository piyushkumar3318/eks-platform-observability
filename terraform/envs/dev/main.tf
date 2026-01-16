module "vpc" {
source = "../../modules/vpc"
env = "dev"
cidr = "10.0.0.0/16"
private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
azs = ["us-west-2a", "us-west-2b"]
}


module "eks" {
source = "../../modules/eks"
env = "dev"
subnet_ids = module.vpc.private_subnet_ids
cluster_role_arn = var.cluster_role_arn
}


module "node_group" {
  source        = "../../modules/node-group"
  env           = "dev"
  cluster_name  = module.eks.cluster_name
  node_role_arn = var.node_role_arn
  subnet_ids    = module.vpc.private_subnet_ids

  instance_types = ["t3.small"]
  capacity_type  = "ON_DEMAND"

  desired_size = 1
  min_size     = 1
  max_size     = 2
}