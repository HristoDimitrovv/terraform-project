### Build Your Own Infrastructure ###

### Execution plan ###

1. Clone the repository.
```hcl
git clone git@github.com:HristoDimitrovv/terraform-project.git
```
2. Deploy the Networking and Services part.
```hcl
cd /terraform-project/terraform/environment/
terraform init
terraform plan
terraform apply 
```
3. Uncomment the backend config found in "providers.tf" and run again "terraform init" in order to sent the tfstate file to the S3 bucket.

4. If you want to deploy the cicd solution pipeline for testing
```hcl
cd /terraform-project/terraform/environment/cicd/
terraform init
terraform plan
terraform apply 
```

