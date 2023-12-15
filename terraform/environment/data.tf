### Take the latest AMI for Amazon Linux 2 ###
data "aws_ami" "latest_amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


### Retrieve the running instances IDs ###
data "aws_instances" "running-instances" {
  instance_state_names = ["running"]
}
