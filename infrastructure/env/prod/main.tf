provider "aws" {
  region = "us-east-1"
}

<<<<<<< HEAD
module "prod" {
  source = "../../modules/root"
  region = var.prod-region
  bucket_name = var.bucket_name
  instance_type = var.instance_type
=======
module "stage-app" {
  source = "../../modules/my-app"
  region = "us-east-1"
  key_name = "my-key"
  instance_type = "t2.micro"
  ami = "ami-0866a3c8686eaeeba"
  db_username = "admin"     # RDS root username
  db_password = "password"  # RDS root user password    
  bucket_name = "my-bucket"   # S3 bucket for frontend            
  domain_name = "example.com" # The domain name for the website.
  state_bucket = "my-state-bucket" # S3 bucket name for state file
>>>>>>> b1b4f410bf2dfd9afe2f3c757fb09bf178e89bce
}