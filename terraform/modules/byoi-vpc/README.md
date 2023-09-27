
### Build Your Own Infrastructure VPC Module ###

1. This module creates a VPC with optional number of AZs, Public, Private and Database subnets. 
2. The number of subnets depends on the number of AZs. You can create only one of each kind of subnet per AZ.
3. VPC flow logging is enabled by default and cannot be disabled.
4. All the subnets are optional and enabled by default, you can choose with a boolean (in the optional inputs) if you do not want to use any of the 3 kinds of subnets.
5. The public Subnet has an IGW and it gets a public IP assigned at launch.
6. The private subnet has an outbound internet access thru a NAT Gateway that is deployed in the public subnet (can be disabled with an optional input).
7. The database subnet has only a local route and no access to the internet.
8. You caan also download the module from https://registry.terraform.io/modules/HristoDimitrovv/vpc/aws/latest


### BASIC USAGE ###

```hcl
module "byoi_vpc" {
  source  = "HristoDimitrovv/vpc/aws"
  version = "1.0.1"

  vpc_name                 = "vpc_name"
  cidr                     = "10.1.0.0/16"
  availability_zones       = ["us-east-1a", "us-east-1b"]
  public_subnets           = ["10.1.11.0/24", "10.1.12.0/24"]
  private_subnets          = ["10.1.21.0/24", "10.1.22.0/24"]
  database_subnets         = ["10.1.31.0/24", "10.1.32.0/24"]
  vpc_flow_log_group       = "vpc_flow_logs_name"

  tags = {
    Deployment  = "terraform"
    Environment = "dev"
  }
}
```

### Example If you do not want to create certain subnets ###

```hcl
module "byoi_vpc" {
  source  = "HristoDimitrovv/vpc/aws"
  version = "1.0.1"

  vpc_name                 = "vpc_name"
  cidr                     = "10.1.0.0/16"
  availability_zones       = ["us-east-1a"]
  public_subnets           = ["10.1.11.0/24"]
  create_private_subnets   = false
  create_database_subnets  = false
  create_nat_gateway       = false
  vpc_flow_log_group       = "vpc_flow_logs_name"

    tags = {
    Deployment  = "terraform"
    Environment = "dev"
  }
}
```



### Required Inputs ###

```hcl
vpc_name string
Description : The name to be assigned to the VPC.

cidr     string
Description : The cidr block to be assigned to the VPC.

vpc_flow_log_group  string
Description : The name of the flow logs group.
```


### Optional Inputs ###

```hcl
enable_dns_hostnames bool
Description : Set to "true" if you want to enable dns_hostnames.
default = null

tags any
Description : Tags to be applied to the resources
default = {}

create_nat_gateway bool
Description : Set to "false" if you want to disable the creation of the Nat Gateway.
default = true

create_public_subnets bool
Description : Set to "false" if you want to disable the creation of the public subnets.If you disable it, you need to disable the Nat Gateway as well as it is deployed here.
default = true

create_private_subnets bool
Description : Set to "false" if you want to disable the creation of the private subnets.
default = true

create_database_subnets bool
Description : Set to "false" if you want to disable the creation of the database subnets.
default = true

igw_name string
Description : Name of the Internet Gateway
default = ""

public_subnets list(string)
Description : The CIDR of the public subnets that you want to be created.
default = []

private_subnets list(string)
Description : The CIDR of the private subnets that you want to be created.
default = []

database_subnets list(string)
Description : The CIDR of the database subnets that you want to be created.
default = []

availability_zones list(string)
Description : The availability zone/s that you want to create.
default = []


```


### Outputs ###

```hcl
vpc_id
Description : The ID of the VPC

public_subnets
Description : The public subnets IDs.

private_subnets
Description : The private subnets IDs.

database_subnets
Description : The database subnets IDs.
```