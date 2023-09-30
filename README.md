### Build Your Own Infrastructure ###

### TASK ###

1. Create an S3 bucket for the Terraform remote state file
2. Change the location of the terraform state to use already created bucket
3. Creating the networking layer
4. Create a VPC and enable VPC Flow Logs
5. Create an appropriate IAM role for the VPC Flow Logs
6. Create the necessary subnets in each of 2 different AZs (6 subnets in total)
7. Create a public subnet for the load balancer
8. Create a private subnet for the application instances
9. Create a private subnet for RDS
10. Create an IGW for the public subnets
11. Create a NAT gateway for the application subnet
12. Create routing table for the public subnets
13. Add default route to the IGW
14. Associate the routing table with the public subnets
15. Create routing tables for the private subnets (1 for application and 1 for RDS)
16. Add default route to the NAT gateway only for the application routing table
17. Associate the routing tables with their respective private subnets
18. Create security groups for the 3 components - load balancer, application instances and RDS
19. Setup access rules according to the component needs
20. Create an ALB or CLB for the application in the public subnets
21. Create the database layer
22. Create an RDS subnet group
23. Create RDS with multi-AZ enabled by choosing one of the following engines: MySQL, MariaDB, Aurora
24. Create the application layer
25. Create an IAM role for the application instances with permissions for CloudWatch Logs and CloudWatch custom metrics
26. Create launch template/configuration for the application instances
27. Select the newest Amazon Linux for your launch configuration's AMI
28. Use the created IAM role in the launch configuration
29. Install and configure httpd with PHP to be used as a web server
30. Pull the web application from https://github.com/HristoDimitrovv/web-app and send the .sql file information to the DB from a mysql client on the web server
31. You must include installation and setup of the CloudWatch Аgent as part of the bootstrap
32. Export /var/log/messages to CloudWatch Logs
33. Export a custom metric for the memory and disk usage to CloudWatch
34. Create an auto scaling group placed in both AZs with min and max count equal to 2
35. Use the launch configuration in the auto scaling group 
36. You need to specify the load balancer in the definition of the auto scaling group
37. Create an SNS topic for alarm notifications
38. You need to manually subscribe your email address to the SNS topic
39. Create 3 CloudWatch Alarms based on metrics which should post to the SNS topic
40. Alarm for CPU usage above 80%
41. Alarm for disk usage above 80%
42. Alarm for memory utilization above 80%



### Execution plan ###

1. Clone the repository.
```hcl
git clone git@github.com:HristoDimitrovv/terraform-project.git
```
2. Deploy the Networking and Services part.
```hcl
cd /terraform-project/terraform/environment/Networking-Services
terraform init
terraform plan
terraform apply 
```
3. Uncomment the backend config found in "/providers.tf" and run again "terraform init" in order to sent the tfstate file to the S3 bucket (it will be used for data input in the application part). You can choose a name of the S3 bucket in the variables.tf file but you will need to specify it in the backend config here and in the application part.

4. Deploy the Application, DB and Monitoring part.
```hcl
cd /terraform-project/terraform/environment/Application-DB-Monitoring
terraform init
terraform plan
terraform apply 
```
5. Here again uncomment the backend config found in "/providers.tf" and run again "terraform init" in order to sent the tfstate file to the S3 bucket. Note that if you have changed the name of the S3 bucket found in the Networking and Services part, you will need to specify this name in the "providers.tf" file in the "backend s3" and also in the "data.tf" file in the "backend s3" part.


