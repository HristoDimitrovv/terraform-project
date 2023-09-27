### Elastic IP for the NAT Gateway ###
resource "aws_eip" "nat" {
  count  = var.create_nat_gateway ? length(var.availability_zones) : 0
  domain = "vpc"
}


### NAT Gateway to server the application private subnet ###
resource "aws_nat_gateway" "nat-gw" {
  count         = var.create_nat_gateway ? length(var.availability_zones) : 0
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id
}


