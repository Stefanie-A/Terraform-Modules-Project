provider "aws" {
  region = "us-east-1"
}

module "prod" {
  source = "../../modules/root"
  region = var.prod-region
  bucket_name = var.bucket_name
  instance_type = var.instance_type
}