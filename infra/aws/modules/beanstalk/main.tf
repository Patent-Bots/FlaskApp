resource "aws_elastic_beanstalk_application" "this" {
  name        = "${local.this_region}-beanstalk-flask-app"
  description = "Elastic Beanstalk application for ${local.this_region} FlaskApp environments."

  appversion_lifecycle {
    service_role          = var.iam_service_role
    max_count             = 32 # Not sure what is reasonable
    delete_source_from_s3 = true
  }
}

# Source code S3 bucket
resource "aws_s3_bucket" "this" {
  bucket = "${local.this_region}-beanstalk-source"
}

# Upload source bundle to S3
resource "aws_s3_object" "this" {
  bucket = aws_s3_bucket.this.id
  key    = "app.zip"
  source = var.local_source_zip
}

resource "aws_elastic_beanstalk_application_version" "this" {
  application = aws_elastic_beanstalk_application.this.name
  name        = var.app_version
  bucket      = aws_s3_bucket.this.id
  key         = aws_s3_object.this.key
}

resource "aws_security_group" "instances" {
  name   = "${local.this_region}-beanstalk-instances-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.instances.id

  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "allow_instances_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.instances.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "alb" {
  name   = "${local.this_region}-beanstalk-alb-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "allow_alb_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.alb.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_alb_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.alb.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

# Just dev environment
resource "aws_elastic_beanstalk_environment" "this" {
  name                = "${local.this_region}-dev"
  application         = aws_elastic_beanstalk_application.this.name
  solution_stack_name = var.solution_stack_name
  version_label       = aws_elastic_beanstalk_application_version.this.name

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.subnet_ids)
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = join(",", var.subnet_ids)
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "true"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = var.iam_instance_profile
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = var.min_size
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.max_size
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.instances.id
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }

  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SecurityGroups"
    value     = aws_security_group.alb.id
  }
}
