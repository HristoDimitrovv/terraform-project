### ALB variables ### 

variable "alb_name" {
  description = "name of the ALB"
  type        = string
}

variable "internal" {
  description = "The type of IP addresses used by the subnets for your load balancer. The possible values are IPv4 or Dualstack."
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "The type of load balancer to create"
  type        = string
  default     = "application"
}

variable "subnets" {
  description = "The subnets for the ALB to be deployed to"
  type        = list(string)
  default     = null
}

variable "security_groups" {
  description = "The security groups of the ALB"
  type        = list(string)
  default     = null
}


### Target Group with Health check ### 

variable "alb_target_group" {
  description = "Name of the target group"
  type        = string
}

variable "target_type" {
  description = "Target typo for the ALB"
  type        = string
  default     = "instance"
}

variable "target_group_port" {
  description = "port to be used for the check"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the ALB"
  type        = string
  default     = null
}

variable "target_group_protocol" {
  description = "Can be either HTTP or HTTPS"
  type        = string
}

variable "health_check" {
  description = "Health check information"
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
    timeout             = 5
    enabled             = true
    interval            = 10
    port                = 80
    protocol            = "HTTP"
    matcher             = "200-299,301"
  }
}


### HTTP Listener ###

variable "listener_port" {
  description = "Port to be used for the listening"
  type        = string
}

variable "listener_protocol" {
  description = "Can be either HTTP or HTTPS"
  type        = string
}

variable "action_type" {
  description = "Can be either forward or redirect"
  type        = string
  default     = "forward"
}

variable "tags" {
  description = "Tags for the bucket"
  type        = map(string)
  default     = {}
}
