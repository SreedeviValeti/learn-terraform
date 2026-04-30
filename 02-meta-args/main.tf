terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "healthcare-claims"
      ManagedBy = "terraform"
    }
  }
}

# count - 2 audit log buckets, referenced as audit_logs[0] and audit_logs[1]
resource "aws_s3_bucket" "audit_logs" {
  count         = 2
  bucket        = "${var.project_prefix}-audit-log"
  force_destroy = true
}

# for_each - one claims bucket per environment, redev"]
resource "aws_s3_bucket" "claims" {
  for_each      = var.environments
  bucket        = "${var.project_prefix}-claims-${each.key}"
  force_destroy = true

  tags = {
    Environment = each.key
    Tier        = each.value.tier
  }
}

# lifecycle: prevent_destroy - terraform errors if
# To remove it later: delete this lifecycle block, then re-plan and destroy
resource "aws_s3_bucket" "claims_archive" {
  bucket        = "${var.project_prefix}-claims-archive"
  force_destroy = true

  lifecycle {
    prevent_destroy = true
  }
}

# lifecycle: create_before_destroy - new bucket created before old one is deleted
resource "aws_s3_bucket" "config_store" {
  bucket        = "${var.project_prefix}-config-store"
  force_destroy = true

  lifecycle {
    create_before_destroy = true
  }
}