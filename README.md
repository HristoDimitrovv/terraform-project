### Build Your Own Infrastructure ###

### TASK ###

1. Create an S3 bucket for the Terraform remote state file
   a. Change the location of the terraform state to use already created bucket
2. Creating the networking layer
   a. Create a VPC and enable VPC Flow Logs
          i. Create an appropriate IAM role for the VPC Flow Logs
   b. Create the necessary subnets in each of 2 different AZs (6 subnets in total)
          i. Create a public subnet for the load balancer
         ii. Create a private subnet for the application instances
        iii. Create a private subnet for RDS
3. Create an IGW for the public subnets
4. Create a NAT gateway for the application subnet
5. Create routing table for the public subnets
6. Add default route to the IGW
7. Associate the routing table with the public subnets
8. Create routing tables for the private subnets (1 for application and 1 for RDS)
    a. Add default route to the NAT gateway only for the application routing table
    b. Associate the routing tables with their respective private subnets
9. Create security groups for the 3 components - load balancer, application instances and RDS
    a. Setup access rules according to the component needs
10. Create an ALB or CLB for the application in the public subnets
11. Create the database layer
    a. Create an RDS subnet group
    b. Create RDS with multi-AZ enabled by choosing one of the following engines: MySQL, MariaDB, Aurora
12. Create the application layer
    a. Create an IAM role for the application instances with permissions for CloudWatch Logs and CloudWatch custom metrics
    b. Create launch template/configuration for the application instances
    c. Select the newest Amazon Linux for your launch configuration's AMI
    d. Use the created IAM role in the launch configuration
    e. Install and configure httpd with PHP to be used as a web server
    f. Pull the web application from https://github.com/HristoDimitrovv/web-app and send the .sql file information to the DB from a mysql client on the web server
    g. You must include installation and setup of the CloudWatch Аgent as part of the bootstrap
    h. Export /var/log/messages to CloudWatch Logs
    i. Export a custom metric for the memory and disk usage to CloudWatch
13. Create an auto scaling group placed in both AZs with min and max count equal to 2
    a. Use the launch configuration in the auto scaling group 
    b. You need to specify the load balancer in the definition of the auto scaling group
14. Create an SNS topic for alarm notifications
    a. You need to manually subscribe your email address to the SNS topic
15. Create 3 CloudWatch Alarms based on metrics which should post to the SNS topic
    a. Alarm for CPU usage above 80%
    b. Alarm for disk usage above 80%
    c. Alarm for memory utilization above 80%


