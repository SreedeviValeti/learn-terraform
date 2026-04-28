terraform {
  required_version = ">=1.5"
  required_providers {
   aws = {
    source = "hashicorp/aws"
    version = "~> 5.0"
   }
  }
}

provider aws {
  region = us-east-1
  default_tags = {
   tags =  {
      Project     = "healthcare-claims-platform"
      ManagedBy   = "terraform"
      Environment = "dev"
  }
}
}

resource "aws_instance" "web" {
  ami = "ami-0ec10929233384c7f"
  instance_type = "t3.micro"
  tags {
    Name = "dev-web-server"
  }
}
