module "byoi_vpc" {
  source = "../modules/byoi-vpc/terraform/"

  vpc_name           = var.vpc_name
  cidr               = var.cidr
  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  database_subnets   = var.database_subnets
  vpc_flow_log_group = var.vpc_flow_log_group

  tags = {
    Deployment  = var.terraform
    Environment = var.environment
  }
}