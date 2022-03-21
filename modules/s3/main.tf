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
  resource_prefix   = "tf"
  workspace         = "${terraform.workspace}"
  resource_name     = "${local.resource_prefix}-${var.product_line}-${var.product_component}-${local.workspace}"
  s3buckettestbucket  = "${var.env_type}-uns-testbucket818345503029"
  tags = {
    EnvType            = "${var.env_type}"
    EnvName            = "${local.workspace}"
    ProductLine        = "${var.product_line}"
    ProductComponent   = "${var.product_component}"
    Provisioner        = "${var.provisioner}"
    OwnerContact       = "${var.owner_contact}"
    MaintenanceContact = "${var.maintenance_contact}"
  }
}

#EMR Pre Requisties
resource "aws_s3_bucket" "testbucket" {
  bucket = local.s3buckettestbucket
  acl    = "private"
  tags = local.tags
}

resource "aws_s3_bucket_public_access_block" "testbucket" {
  bucket = aws_s3_bucket.testbucket.id
  block_public_acls   = true
  block_public_policy = true
  restrict_public_buckets = true
  ignore_public_acls = true
}