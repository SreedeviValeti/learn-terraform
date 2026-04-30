variable "aws_region" {
 description = "region"
 type = string
 default = "us-east-1"
}

variable "project_prefix" {
 type = string
 description = "Globally unique prefix for S3 bucket names — must be lowercase, no spaces"
}


variable "environments" {
  type = map(object({tier = string}))
  default = {
    dev = {
	  tier = "developement"
	  }
	test = {
	 tier = "staging"
	}
	prod = {
	 tier = "production"
	}
  }
}