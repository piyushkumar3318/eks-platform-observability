resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.env}-node-group"
  node_role_arn  = var.node_role_arn
  subnet_ids     = var.subnet_ids

  instance_types = var.instance_types
  capacity_type  = var.capacity_type

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  labels = {
    environment = var.env
  }

  tags = {
    Name        = "${var.env}-node-group"
    Environment = var.env
  }
}
