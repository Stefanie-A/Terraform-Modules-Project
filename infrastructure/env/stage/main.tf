provider "aws" {
  region = "us-east-1"
}

<<<<<<< HEAD
module "staging" {
  source = "../../modules/root"
  state_bucket = var.state_bucket
=======
module "stage-app" {
  source = "../../modules/my-app"
  state_bucket = var.state_bucket
  db_password = var.db_password
  db_username = var.db_username
>>>>>>> b1b4f410bf2dfd9afe2f3c757fb09bf178e89bce
  bucket_name = var.bucket_name
  instance_type = var.instance_type
}