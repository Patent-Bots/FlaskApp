variable "iam_service_role" {
  type        = string
  description = "IAM service role for Beanstalk to assume."
}

variable "iam_instance_profile" {
  type        = string
  description = "IAM instance profile "
}

variable "solution_stack_name" {
  type        = string
  description = "AWS Beanstalk Python platform version name, eg \"64bit Amazon Linux 2023 v4.7.2 running Python 3.13\"."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to deploy Beanstalk instances in."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets to deploy Beanstalk instances in."
}

variable "local_source_zip" {
  type        = string
  description = "Path to zipped Python application to deploy in Beanstalk."
}

variable "app_version" {
  type        = string
  description = "Version label of application being deployed in Beanstalk."
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for the Beanstalk environment."
}

variable "min_size" {
  type        = number
  description = "Minimum number of instances for the Beanstalk environment."
}

variable "max_size" {
  type        = number
  description = "Maximum number of instances for the Beanstalk environment."
}
