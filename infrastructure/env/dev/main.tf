provider "aws" {
  region = "us-east-1"
}

module "dev" {
  source = "../../modules/root"
  region = var.dev-region
  bucket_name = var.bucket_name
  instance_type = var.instance_type
}