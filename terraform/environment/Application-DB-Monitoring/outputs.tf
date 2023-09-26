output "rds_endpoint" {
  value = module.byoi_rds.rds_hostname
}

output "lb_dns_name" {
  value = module.byoi_alb.lb_dns_name
}

output "alb_target_group_arn" {
  value = module.byoi_alb.alb_target_group_arn
}