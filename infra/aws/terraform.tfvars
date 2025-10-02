networking = {
  us_east_1 = {
    vpc_cidr = "10.0.0.0/16"
    public_subnets = {
      a = "10.0.1.0/24"
      b = "10.0.2.0/24"
    }
  }
}

beanstalk_solution_stack_name = "64bit Amazon Linux 2023 v4.7.2 running Python 3.13"
beanstalk_app_version = "v1"
beanstalk_zip_path = "app.zip"

beanstalk_instance_type = "t2.micro"
beanstalk_min_size = 1
beanstalk_max_size = 2
