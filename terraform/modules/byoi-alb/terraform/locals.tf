### Locals to deploy the ALB in the default VPC, one of the defaul Subnets and the default SG if not specified in the root module ###
locals {
  vpc_id = (
    var.vpc_id == null
    ? data.aws_vpc.default.id
    : var.vpc_id
  )

  subnets = (
    var.subnets == null
    ? [data.aws_subnets.default[0].ids[0]]
    : []
  )

  security_groups = (
    var.security_groups == null
    ? [data.aws_security_group.default[0].id]
    : var.security_groups
  )
}
