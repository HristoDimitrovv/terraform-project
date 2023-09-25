### Build Your Own Infrastructure RDS database Module ###

1. This module creates an RDS database
2. You can choose if you want it to be in multi_az or not
3. You can choose to use a randomly generated password during the creation which will be sent to SSM parameter store and you can then use it with your app securely
4. The subnet ids and security groups to be assigned are optional values. If you do not set values for them the RDS will be created with the default VPC SG and in 1 of the default VPC subnets.


### BASIC USAGE ###

```hcl
module "byoi_rds" {
  source = "./byoi-rds/terraform/"

  db_subnet_name          = "rds-subnet"
  subnet_ids              = ["10.1.31.0/24"]              /// Optional
  allocated_storage       = 10
  db_name                 = "rds"
  engine                  = "mariadb"
  engine_version          = "10.6.10"
  instance_class          = "db.t2.micro"
  username                = "user"
  create_random_password  = true
  port                    = "3306"
  skip_final_snapshot     = true
  multi_az                = false
  vpc_security_groups_ids = [aws_security_group.rds.id]   /// Optional

    tags = {
    Deployment  = var.terraform
    Environment = var.environment
  }
}
```


### Required Inputs ###

```hcl
db_subnet_name string
Description : The name for the DB subnetnet group.

allocated_storage number
Description : The storage in GB that will be assigned to the db_engine.

db_name string
Description : The name for the RDS.

engine string
Description : The engine for the DB like mariadb, Mysql etc..

instance_class string
Description : Only free tier is allowed: db.t2.micro | db.t3.micro

username string
Description : The username for the DB access.

create_random_password bool
Description : If set to "true" a random password will be set and send to SSM. Else if "false" you need to manually set a password by adding a "password" field.

port string
Description : The port for the DB engine access like 3306 for MySQL and MariaDB.

skip_final_snapshot bool
Description : Set to "false" if you want to skip the snapshot creation.

multi_az bool
Description : Set to "true" if you want to deploy the DB in 2 AZ's.

```


### Optional Inputs ###

```hcl

subnet_ids list(string)
Description : The subnet/s that the RDS needs to be deployed. If not specified it will be created in one of the default subnets of the default VPC.

vpc_security_groups_ids list(string)
Description : The security group ID for the RDS instance. If not specified it will be created in the default VPC SG.

tags map(string)
Description : Choose the tags to be applied to the bucket.
```


### Outputs ###

```hcl
rds_endpoint
Description : The endpoint FQDN address
```
