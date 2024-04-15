#-------------------------------------------------
# ##### Arquivo de Incialização do Terraform #####
#-------------------------------------------------
terraform {
  required_version = ">= 1.6.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }

  backend "s3" {
    bucket = "${local.account_id}-remotestate"
    key    = "prj-mwaa/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = {
      owner      = "tavares"
      managed-by = "terraform"
    }
  }
}
