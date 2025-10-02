module "iam" {
  source = "./modules/iam"
}

module "us_east_1_networking" {
  source = "./modules/networking"

  vpc_cidr        = var.networking["us_east_1"].vpc_cidr
  public_subnets = var.networking["us_east_1"].public_subnets

  # Could omit this to use default provider
  providers = {
    aws = aws.us_east_1
  }
}

module "us_east_1_beanstalk" {
  source = "./modules/beanstalk"

  iam_service_role     = module.iam.beanstalk_service_role_arn
  iam_instance_profile = module.iam.beanstalk_instance_profile_name
  solution_stack_name  = var.beanstalk_solution_stack_name
  vpc_id               = module.us_east_1_networking.vpc_id
  subnet_ids           = module.us_east_1_networking.public_subnet_ids

  instance_type = var.beanstalk_instance_type
  min_size      = var.beanstalk_min_size
  max_size      = var.beanstalk_max_size

  app_version      = var.beanstalk_app_version
  local_source_zip = var.beanstalk_zip_path

  providers = {
    aws = aws.us_east_1
  }
}
