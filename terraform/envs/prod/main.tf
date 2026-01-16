# Production environment
# This environment is intentionally not applied from local machines.
# Changes are expected to go through CI/CD with approvals.

module "vpc" {
  source = "../../modules/vpc"
  env    = "prod"

  # CIDR ranges and subnets are larger in prod
  cidr            = "10.1.0.0/16"
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
  azs             = ["us-west-2a", "us-west-2b"]
}

module "eks" {
  source           = "../../modules/eks"
  env              = "prod"
  subnet_ids       = module.vpc.private_subnet_ids
  cluster_role_arn = var.cluster_role_arn
}

# Node group intentionally omitted
# Production capacity and scaling are environment-specific
