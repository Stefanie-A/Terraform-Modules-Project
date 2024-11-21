terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
  # backend "s3" {
  #   key            = "state/terraform.tfstate"
  #   bucket         = "terraformstate-file"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-state-locks"
  #   encrypt        = true
  # }
  required_version = ">=1.2.0"
}

provider "aws" {
  region = "us-east-1"
}