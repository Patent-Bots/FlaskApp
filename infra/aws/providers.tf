terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.9.0"
    }
  }
}

# Default
provider "aws" {
  region = "us-east-1"
}

# Can use as an explicit region as well as the default
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}