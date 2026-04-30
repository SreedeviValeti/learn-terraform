variable "aws_region" {
  type = string
  description = "AWS Region"
  default = "us-east-1"
  validation {
    condition = contains(["us-east-1"], var.aws_region)
	error_message = "In valid region, Please make sure to provision infra in us-east-1 region only"
   }
}

variable "environment" {
  type = string
  description = "Environment"
  default = "dev"
  validation {
    condition = contains(["dev","test"], var.environment)
	error_message = "In valid region, Please make sure to provision infra in us-east-1 region only"
   }
}

variable "instance_type" {
  type = string
  description = "Instancetype"
  default = "t3.micro"
}

variable "project_name" {
  description = "Project name used in resource naming and tags"
  type        = string
  default     = "healthcare-claims-platform"
}