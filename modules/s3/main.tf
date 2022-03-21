terraform {
  required_providers { aws = "~> 3.60" }
  required_version = "0.15.4"
  backend "s3" {
    key    = "service_layer/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {
}

locals {
  s3buckettestbucket  = "${var.env_type}-uns-testbucket818345503029"
  common_tags = {
    EnvType            = var.env_type
    MaintenanceContact = var.maintenance_contact
    ProductLine        = var.product_line
    Provisioner        = var.provisioner
    OwnerContact       = var.owner_contact
  }
}

#EMR Pre Requisties
resource "aws_s3_bucket" "testbucket" {
  bucket = local.s3buckettestbucket
  acl    = "private"
    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = merge(
    {
      Name = "tf-${var.env_type}-${var.product_line}-audit_trans_columns"
    },
    local.common_tags,
    )
}

resource "aws_s3_bucket_public_access_block" "testbucket" {
  bucket = aws_s3_bucket.testbucket.id
  block_public_acls   = true
  block_public_policy = true
  restrict_public_buckets = true
  ignore_public_acls = true
}