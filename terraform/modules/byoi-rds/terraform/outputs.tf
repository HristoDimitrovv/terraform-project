output "rds_hostname" {
  value = split(":", aws_db_instance.rds.endpoint)[0]
}