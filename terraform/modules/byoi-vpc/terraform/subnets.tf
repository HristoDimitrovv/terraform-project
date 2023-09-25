
### Public subnets for each AZ ###
resource "aws_subnet" "public_subnets" {
  count             = var.create_public_subnets ? length(var.availability_zones) : 0
  vpc_id            = aws_vpc.byoi_vpc.id
  cidr_block        = element(var.public_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
}


### Private subnets for each AZ ###
resource "aws_subnet" "private_subnets" {
  count             = var.create_private_subnets ? length(var.availability_zones) : 0
  vpc_id            = aws_vpc.byoi_vpc.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
}


### Database private subnets for each AZ ###
resource "aws_subnet" "database_subnets" {
  count             = var.create_database_subnets ? length(var.availability_zones) : 0
  vpc_id            = aws_vpc.byoi_vpc.id
  cidr_block        = element(var.database_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
}