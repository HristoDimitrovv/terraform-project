### Internet Gateway ###
resource "aws_internet_gateway" "igw" {
  count  = var.create_public_subnets ? 1 : 0
  vpc_id = aws_vpc.byoi_vpc.id
}


### Public route table  ### 
resource "aws_route_table" "public-route" {
  count  = var.create_public_subnets ? 1 : 0
  vpc_id = aws_vpc.byoi_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id
  }
}


### Private route table  ### 
resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.byoi_vpc.id
  count  = var.create_private_subnets ? length(var.availability_zones) : 0

  route {
    cidr_block     = var.create_nat_gateway ? "0.0.0.0/0" : null
    nat_gateway_id = var.create_nat_gateway ? aws_nat_gateway.nat-gw[count.index].id : 0
  }
}


### Database route table ### 
resource "aws_route_table" "database-route" {
  count  = var.create_database_subnets ? 1 : 0
  vpc_id = aws_vpc.byoi_vpc.id
}


### Public subnet route table associations ### 
resource "aws_route_table_association" "public_route" {
  count          = var.create_public_subnets ? length(aws_subnet.public_subnets) : 0
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = element(aws_route_table.public-route[*].id, count.index)
}


### Private subnet route table associations ### 
resource "aws_route_table_association" "private_route" {
  count          = var.create_private_subnets ? length(aws_subnet.private_subnets) : 0
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private-route[count.index].id
}


### Database subnet route table associations ### 
resource "aws_route_table_association" "database_route" {
  count          = var.create_database_subnets ? length(aws_subnet.database_subnets) : 0
  subnet_id      = aws_subnet.database_subnets[count.index].id
  route_table_id = element(aws_route_table.database-route[*].id, count.index)
}