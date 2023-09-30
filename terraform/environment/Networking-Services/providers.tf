terraform {
  required_version = ">= 1.4.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.67.0"
    }
  }

  ### Backend config got tfstate file to be send to S3 ###
  # backend "s3" {
  #   bucket = "hrdimibucket222222"
  #   key    = "./vpc-terraform.tfstate"
  #   region = "us-east-1"
  # }
}