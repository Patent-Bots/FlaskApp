zip app.zip application.py requirements.txt
mv app.zip infra/aws/ # janky, this is a demo setup!
cd infra/aws
terraform init
terraform apply