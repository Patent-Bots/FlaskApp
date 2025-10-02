output "beanstalk_service_role_arn" {
  description = "ARN of the Beanstalk service role."
  value       = aws_iam_role.beanstalk_service.arn
}

output "beanstalk_instance_profile_name" {
  description = "Name of the Beanstalk EC2 instance profile."
  value       = aws_iam_instance_profile.beanstalk_ec2.name
}