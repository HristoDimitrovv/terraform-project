### Create the database network layer ###
resource "aws_db_subnet_group" "rds_subnet" {
  name       = var.db_subnet_name
  subnet_ids = local.subnet_ids
}


### Create the RDS ###
resource "aws_db_instance" "rds" {
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  username               = var.username
  password               = var.create_random_password ? data.aws_ssm_parameter.db_password[0].value : var.password
  port                   = var.port
  skip_final_snapshot    = var.skip_final_snapshot
  multi_az               = var.multi_az
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet.name
  vpc_security_group_ids = local.vpc_security_group_ids
}