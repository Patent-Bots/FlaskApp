variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Map of AZ suffixes to CIDR blocks"
  type        = map(string)
}
