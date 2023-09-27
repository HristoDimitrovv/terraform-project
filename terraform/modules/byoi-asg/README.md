### Build Your Own Infrastructure ASG Module ###

1. This module creates an ASG
2. It has some default values that you can check in the Optional inputs and can override if you want to.
3. The vpc_zone_identifier and vpc_security_group_ids to be assigned are optional values. If you do not set values for them the ASG will be created with the default VPC SG and in 1 of the default VPC subnets.

### BASIC USAGE ###

```hcl
module "byoi_asg" {
  source = "../../modules/byoi-asg/terraform"

  name                      = "my_asg"
  max_size                  = 2
  min_size                  = 2
  desired_capacity          = 2
  health_check_grace_period = 100
  health_check_type         = "ELB"
  vpc_zone_identifier       = ["10.1.21.0/24"]               /// Optional

  instance_refresh = {                                       /// Optional
    strategy = "Rolling"
    preferences  = {
      checkpoint_delay       = 5
      instance_warmup        = 80
      min_healthy_percentage = 40
    }
  }

  tags = {
    Deployment  = "terraform"
    Environment = "dev"
  }

  ### Launch Template ###
  launch_template_name   = "my_template"
  image_id               = "my_ami"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.asg.id]      /// Optional

  tags = {
    Deployment  = "terraform"
    Environment = "dev"
  }
}
```


### Required Inputs ###

```hcl
name string
Description : The name for the ASG.

max_size number
Description : The maximum number of instances to be deployed. There is a limit set to 10 and cannot be 0.

min_size number
Description : The maximum number of instances to be deployed. There is a limit set to 10 and cannot be 0.

desired_capacity number
Description : The maximum number of instances to be deployed. There is a limit set to 10 and cannot be 0.

health_check_grace_period number
Description : The grace period between health hecks

instance_type string
Description : The type of the instance. Can be only t2.micro or t3.micro in order to use the free tier only.

image_id string
Description : The image to be used for the instances.

launch_template_name string
Description : The name of the Launch template.

```


### Optional Inputs ###

```hcl

vpc_zone_identifier list(string)
Description : The subnets where the ASG can be deployed. If not specified it will be deployed in one of the default VPC subnets.

target_group_arns string
Description : If using an ALB set its ARN to connect the ASG to it.
Default = null

template_version string
Description : The version of the Launch template to be used.
Default = "Latest"

user_data string
Description : User data to be executed on the newly deployed instances.
Default = null

tags map(string)
Description : Choose the tags to be applied to the bucket.

instance_refresh object
Description : Instance refresh parameters. You can override them in the root module with "instance_refresh = {}" and assign all field values as shown below
  type = object({
    strategy = string
    preferences = object({
      checkpoint_delay       = number
      instance_warmup        = number
      min_healthy_percentage = number
    })
  })
  default = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 10
      instance_warmup        = 100
      min_healthy_percentage = 50
    }
  }

```


### Outputs ###

```hcl
asg_name
Description : The ASG name
```
