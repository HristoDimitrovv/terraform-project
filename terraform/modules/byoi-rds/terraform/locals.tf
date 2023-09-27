### Locals to deploy the RDS in the default VPC, one of the defaul Subnets and the default SG if not specified in the root module ###

locals {
  vpc_id = (
    var.vpc_id == null
    ? data.aws_vpc.default.id
    : var.vpc_id
  )

  subnet_ids = (
    var.subnet_ids == null
    ? [data.aws_subnets.default[0].ids[0]]
    : var.subnet_ids
  )

  vpc_security_group_ids = (
    var.vpc_security_group_ids == null
    ? [data.aws_security_group.default[0].id]
    : var.vpc_security_group_ids
  )
}