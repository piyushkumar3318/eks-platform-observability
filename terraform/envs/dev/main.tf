terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

#######################################
# VPC MODULE
#######################################
module "vpc" {
  source = "../../modules/vpc"

  env             = "dev"
  cidr            = "10.0.0.0/16"
  azs             = ["us-west-2a", "us-west-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}

#######################################
# EKS CLUSTER MODULE
#######################################
module "eks" {
  source = "../../modules/eks"

  env         = "dev"
  cluster_name = "dev-eks-cluster"
  cluster_role_arn = var.cluster_role_arn
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
}

#######################################
# NODE GROUP MODULE
#######################################
module "node_group" {
  source = "../../modules/node-group"

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


