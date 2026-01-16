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
  region = "us-west-2"
}

#######################################
# VPC MODULE
#######################################
module "vpc" {
  source = "../../modules/vpc"

  env             = "prod"
  cidr            = "10.1.0.0/16"
  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
}

#######################################
# EKS CLUSTER MODULE
#######################################
module "eks" {
  source = "../../modules/eks"

  env         = "prod"
  cluster_name = "prod-eks-cluster"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
}

#######################################
# NODE GROUP MODULE
#######################################
module "node_group" {
  source = "../../modules/node-group"

  env           = "prod"
  cluster_name  = module.eks.cluster_name
  node_role_arn = var.node_role_arn
  subnet_ids    = module.vpc.private_subnet_ids

  instance_types = ["t3.medium"]
  capacity_type  = "ON_DEMAND"

  desired_size = 2
  min_size     = 2
  max_size     = 4
}
