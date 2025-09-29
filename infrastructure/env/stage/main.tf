provider "aws" {
  region = "us-east-1"
}

module "staging" {
  source = "../../modules/root"
  state_bucket = var.state_bucket
  bucket_name = var.bucket_name
  instance_type = var.instance_type
}