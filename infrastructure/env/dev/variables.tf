variable "dev-region" {
    description = "development region"
    default = "us-east-2"
  
}
variable "bucket_name" {
  description = "Application bucket name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}
