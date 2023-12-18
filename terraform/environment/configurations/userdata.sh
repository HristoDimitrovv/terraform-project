#!/bin/bash

### Send the output of the script in a log file ### 
LOG_FILE=/tmp/bootstrap.log
exec &> $LOG_FILE

### Install the neccessary tools ###
yum -y update
yum install -y httpd php mysql php-mysqlnd git

#### Enable the httpd and SSM and CW agent services ###
systemctl enable --now httpd amazon-cloudwatch-agent

### Pull the web app and configure it ###
git clone https://github.com/HristoDimitrovv/web-app &&
sed -i "s/Password1/$(aws ssm get-parameter --region us-east-1 --name '/myapp/dbpassword' --with-decryption --output text --query 'Parameter.Value')/" web-app/web/config.php
sed -i "s|Password1|$(aws ssm get-parameter --region us-east-1 --name "/myapp/dbpassword" --with-decryption --output text --query 'Parameter.Value')|" web-app/db/db_setup.sql
sed -i "s/\$database = .*/\$database = \"${DATABASE}\";/" web-app/web/config.php
sed -i "s/\$user = .*/\$user = \"${DB_USERNAME}\";/" web-app/web/config.php
sed -i "s/\$host = .*/\$host = \"${DB_HOSTNAME}\";/" web-app/web/config.php
cp -v web-app/web/* /var/www/html/

### Configure the CW agent ###
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c ssm:cw-metrics.json -s

### Restart the httpd and CW services to apply the new configurations ###
systemctl restart httpd amazon-cloudwatch-agent

### Apply the .sql content to the RDS ###
mysql -v --skip-ssl -u "${DB_USERNAME}" -p"$(aws ssm get-parameter --region us-east-1 --name "/myapp/dbpassword" --with-decryption --output text --query 'Parameter.Value')" -h "${DB_HOSTNAME}" < web-app/db/db_setup.sql
