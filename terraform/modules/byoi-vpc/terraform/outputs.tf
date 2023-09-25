output "vpc_id" {
  value = aws_vpc.byoi_vpc.id
}

output "public_subnets" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnets" {
  value = aws_subnet.private_subnets[*].id
}

output "database_subnets" {
  value = aws_subnet.database_subnets[*].id
}