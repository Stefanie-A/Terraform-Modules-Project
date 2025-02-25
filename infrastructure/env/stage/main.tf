provider "aws" {
  region = "us-east-1"
}

module "stage-app" {
  source = "../../modules/my-app"
  state_bucket = var.state_bucket
  db_password = var.db_password
  db_username = var.db_username
  bucket_name = var.bucket_name
  instance_type = var.instance_type
}