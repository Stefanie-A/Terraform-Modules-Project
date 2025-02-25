provider "aws" {
  region = "us-east-1"
}

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
}