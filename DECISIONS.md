## Tooling choices

- Uses modules to reuse Terraform code over multiple regions (and environments in the future) – trading initial development complexity for legibility

## Assumptions

- Will want to deploy in more than one region
- (Currently) Single environment

## Next steps

- Private subnets with NAT gateways
- HTTPS
- Dev, Test and Production environments:
    - Have Dev and Test use the default us-east-1 provider, Production replicated in multiple regions
    - Different Beanstalk solution stacks and app versions used by each environment
    - S3 statefiles per environment
- Could use commit SHA for zips to make the uploaded version explicit
- CI/CD

An all over again for App Engine!

### Blue/Green

Create two invocations of Beanstalk module per production region, changing solution stacks and app versions in the new deployment. Then swap public DNS record to use the new deployment's endpoint.

### DB secrets management

Store credentials in Secrets Manager, create a Terraform resource referencing the secret and give Beanstalk environments an IAM instance profile to access at runtime (plus all the IAM Terraform resources).
