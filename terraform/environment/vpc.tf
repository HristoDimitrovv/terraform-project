module "byoi_vpc" {
  source = "../modules/byoi-vpc/terraform/"

  cidr                   = var.cidr
  availability_zones     = var.availability_zones
  public_subnets         = var.public_subnets
  private_subnets        = var.private_subnets
  database_subnets       = var.database_subnets
  vpc_flow_log_group     = var.vpc_flow_log_group
  create_nat_gateway     = false

  tags = {
    Deployment  = var.deployment
    Environment = var.environment
    Name        = var.vpc_name
  }
}
