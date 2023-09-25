### Create random password resource in SSM parameter store ###
resource "aws_ssm_parameter" "db_password" {
  count      = var.create_random_password ? 1 : 0
  name       = "/myapp/dbpassword"
  type       = "SecureString"
  value      = random_password.password[count.index].result
  depends_on = [random_password.password]
}


### Generate the random password ###
resource "random_password" "password" {
  count   = var.create_random_password ? 1 : 0
  length  = 16
  special = false
}