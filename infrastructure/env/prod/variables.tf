variable "prod-region" {
    description = "production region"  
}
variable "bucket_name" {
  description = "Application bucket name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}
