### Build Your Own Infrastructure ALB Module ###

1. This module creates an ALB
2. It has some default values that you can check in the Optional inputs and can override if you want to.
3. The subnet ids, security groups and the VPC id to be assigned are optional values. If you do not set values for them the ALB will be created with the default VPC SG and in 1 of the default VPC subnets.


### BASIC USAGE ###

```hcl
module "byoi_alb" {
  source = "../../modules/byoi-alb/terraform"

  alb_name           = "my_alb"
  internal           = false                         /// Optional 
  load_balancer_type = "application"                 /// Optional 
  subnets            = ["10.1.11.0/24]               /// Optional 
  security_groups    = [aws_security_group.alb.id]   /// Optional 

  ### Target Group with Health check ###

  alb_target_group      = "my_target_group_name"
  target_type           = "instance"                /// Optional 
  vpc_id                = aws_vpc.my_vpc.id         /// Optional 
  target_group_port     = "80"
  target_group_protocol = "HTTP"

  health_check = {                                 /// Optional 
    healthy_threshold   = 5
    unhealthy_threshold = 10
    timeout             = 5
    enabled             = true
    interval            = 10
    port                = 80
    protocol            = "HTTP"
    matcher             = "200-299,301"
  }

  ### Listener rule ###

  action_type       = "forward"                     /// Optional
  listener_port     = "80"
  listener_protocol = "HTTP""
}

  tags = {
    Deployment  = "terraform"
    Environment = "dev"
  }
```


### Required Inputs ###

```hcl
alb_name string
Description : The name for the ALB.

alb_target_group string
Description : The name of the ALB target group.

target_group_port string
Description : The port to be used for the instance check, it is usually set to "80".

target_group_protocol string
Description : The protocol to be used for the instance check, it is usually set to "HTTP".

listener_port string
Description : The port to be used for the listener, it is usually set to "80", if you want "443" you will need to create a certificate first usin Certificate Manager.

listener_protocol string
Description : The protocol to be used for the listener, it is usually set to "HTTP", if you want "HTTPS" you will need to create a certificate first usin Certificate Manager.

```


### Optional Inputs ###

```hcl


internal bool
Description : Set to "true" if you want the ALB to be internal only and set to "false" if you want it to be external (serving public traffic).
Default = false

load_balancer_type string
Description : The type of load balancer. Can be "application", "gateway" or "network".
Default = "application"

target_type string
Description : The target type. Can be "instance", "lambda", "ip" or "alb". With target type "lambda" the instance health check are disabled by default.
Default = "instance"

action_type string
Description : The action type for the listener. Can be "forward", "redirect", "fixed-response", "authenticate-cognito" and "authenticate-oidc"
Default = "forward"

subnet_ids list(string)
Description : The subnet/s that the ALB needs to be deployed. If not specified it will be created in one of the default subnets of the default VPC.

vpc_security_groups_ids list(string)
Description : The security group ID for the ALB instance. If not specified it will be created in the default VPC SG.

vpc_ids string
Description : The VPC ID that you want to use. If you do not set it, it will use the default VPC ID.

tags map(string)
Description : Choose the tags to be applied to the bucket.

health_check
Description = Health check parameters. You can override them in the root module with "health_check = {}" and assign all field values as shown below
  type = object({
    healthy_threshold   = number
    unhealthy_threshold = number
    timeout             = number
    enabled             = bool
    interval            = number
    port                = number
    protocol            = string
    matcher             = string
  })
  default = {
    healthy_threshold   = 5
    unhealthy_threshold = 10
    timeout             = 10
    enabled             = true
    interval            = 5
    port                = 80
    protocol            = "HTTP"
    matcher             = "200-299,301"
  }

```


### Outputs ###

```hcl
lb_dns_name
Description : ALB DNS name

alb_target_group_arn
Description : ALB target group ARN
```
