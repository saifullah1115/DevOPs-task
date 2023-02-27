provider "aws" {
  region = "us-east-1"
  //shared_credentials_file = "~/.aws/credentials"
  //access_key = ""
  //secret_key = ""
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.54.0"
    }
  }
}