output "us_east_1_dev_url" {
  description = "US East 1 dev URL."
  value       = module.us_east_1_beanstalk.dev_endpoint
}