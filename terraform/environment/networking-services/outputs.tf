output "vpc_id" {
  value = module.byoi_vpc.vpc_id
}

output "public_subnets" {
  value = module.byoi_vpc.public_subnets
}

output "database_subnets" {
  value = module.byoi_vpc.database_subnets
}

output "private_subnets" {
  value = module.byoi_vpc.private_subnets
}

output "sns_topic_arn" {
  value = aws_sns_topic.alarm.arn
}

output "bucket_id" {
  value = module.byoi_s3.bucket_id
}