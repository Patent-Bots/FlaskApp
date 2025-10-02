output "dev_endpoint" {
  description = "URL of the Beanstalk dev environment."
  value       = aws_elastic_beanstalk_environment.this.cname
}
