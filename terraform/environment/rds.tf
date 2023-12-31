module "byoi_rds" {
  source = "../modules/byoi-rds/terraform/"

  db_subnet_name         = var.db_subnet_name
  subnet_ids             = module.byoi_vpc.database_subnets
  allocated_storage      = var.allocated_storage
  engine                 = var.db_engine
  identifier             = var.db_identifier
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  username               = var.db_username
  port                   = var.db_port
  skip_final_snapshot    = var.skip_final_snapshot
  multi_az               = var.multi_az
  vpc_security_group_ids = [aws_security_group.rds.id]

  tags = {
    Deployment  = var.deployment
    Environment = var.environment
  }
}