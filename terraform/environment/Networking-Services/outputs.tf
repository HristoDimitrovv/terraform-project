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

output "lb_dns_name" {
  value = module.byoi_alb.lb_dns_name
}

output "alb_target_group_arn" {
  value = module.byoi_alb.alb_target_group_arn
}

output "sns_topic_arn" {
  value = aws_sns_topic.alarm.arn
}

output "bucket_id" {
  value = module.byoi_s3.bucket_id
}