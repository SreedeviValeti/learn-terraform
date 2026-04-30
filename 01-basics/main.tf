terraform {
  required_version = ">=1.5"
  required_providers {
   aws = {
    source = "hashicorp/aws"
    version = "~> 5.0"
   }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags  {
   tags =  {
      Project     = "healthcare-claims-platform"
      ManagedBy   = "terraform"
      Environment = var.environment
  }
}
}

resource "aws_instance" "web" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = "subnet-011eaeaf069bf21a1"
  vpc_security_group_ids = ["sg-091aa505b15c5471d"]
  tags = {
    Name = "dev-web-server"
  }
}

resource "aws_instance" "test" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  subnet_id = "subnet-09995cd0f7972cd19"
  vpc_security_group_ids = ["sg-091aa505b15c5471d"]
  tags = {
    Name = "test-server"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical (official Ubuntu account)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
