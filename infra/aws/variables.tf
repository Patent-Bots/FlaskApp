variable "networking" {
  description = "VPC definitions by region."
  type = map(object({
    vpc_cidr        = string
    public_subnets = map(string)
    }
  ))
}

variable "beanstalk_zip_path" {
  type        = string
  description = "Path to zipped Python application to deploy in Beanstalk."
}

variable "beanstalk_app_version" {
  type = string
  description = "Application version being deployed in Beanstalk."
}

variable "beanstalk_solution_stack_name" {
  type        = string
  description = "Elastic Beanstalk solution stack name."
}

variable "beanstalk_instance_type" {
  type        = string
  description = "Elastic Beanstalk instance type."
}

variable "beanstalk_min_size" {
  type        = number
  description = "Elastic Beanstalk min size."
}

variable "beanstalk_max_size" {
  type        = number
  description = "Elastic Beanstalk max size."
}
