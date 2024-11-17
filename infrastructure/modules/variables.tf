variable "pub_subnets_cidr" {
  description = "public subnet cidr block"
  type = list(string)
  default = [ "10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24" ]
}
variable "pri_subnets_cidr" {
  description = "private subnet cidr block"
  type = list(string)
  default = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
}
variable "azs" {
  type = list(string)
  description = "Availablity zone for public subnet"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "my-key"
}
variable "region" {
  type = string
  description = "vpc region"
  default = "us-east-1"
}
variable "security_group" {
  type = string
  description = "security group"
  default = "main_sg"
}
variable "instance_type" {
  type = string
  description = "Instance type for load balancer"
}
variable "ami" {
  type = string
  description = "Instance type for load balancer"
  default = "ami-0866a3c8686eaeeba"    
  validation {
  condition     = length(var.ami) > 4 && substr(var.ami, 0, 4) == "ami-"
  error_message = "Please provide a valid value for variable AMI."
 }
}
variable "db_username" {
  description = "RDS root username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}

variable "allowed_repos_branches" {
  description = "GitHub repos/branches allowed to assume the IAM role."
  type = list(object({
    org = string
    repo = string
    branch = string
  }))
  default = [ 
    {
    org = "Stefanie-A"
    repo = "aws-3tier"
    branch = "main"
 }
 ]
}
