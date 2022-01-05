#!/bin/bash

sudo yum update -y
sudo yum install -y mysql git wget
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo yum install -y dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm

# this section is to install EFS util for mounting to the file system

git clone https://github.com/aws/efs-utils

cd ~/efs-utils

sudo yum install -y make

sudo yum install -y rpm-build

make rpm 

sudo yum install -y  ./build/amazon-efs-utils*rpm

mkdir /var/www/
sudo mount -t efs -o tls,accesspoint=fsap-057a84e9b65546025 fs-0de3eca94112794b7:/ /var/www/
yum install -y httpd 
systemctl start httpd
systemctl enable httpd
yum module reset php -y
yum module enable php:remi-7.4 -y
yum install -y php php-common php-mbstring php-opcache php-intl php-xml php-gd php-curl php-mysqlnd php-fpm php-json
systemctl start php-fpm
systemctl enable php-fpm
git clone https://github.com/darey-devops/tooling.git
mkdir /var/www/html
cp -R /home/ec2-user/tooling/html/*  /var/www/html/
sudo setenforce Permissive
sestatus
cd /var/www/html/
touch healthstatus
sudo curl -v localhost/healthstatus


# Configure App connectivity to the database 
cd /var/www/html/ && vi db_conn.php
mysql -h terraform-20220102120944616100000005.cuno0cvdscyv.us-east-1.rds.amazonaws.com -u project15 -p 

# Export the tooling_db_schema.sql
mysql -h terraform-20220102120944616100000005.cuno0cvdscyv.us-east-1.rds.amazonaws.com -u project15 -p    < tooling_db_schema.sql
PW - pblproject15

-- Developers have given the database name to use 
-- Developers have provided the SQL script to load into the database 
-- Configure the server (Update httpd conf to serve PHP files instead of HTML)

tail -f /var/log/nginx/error.log
tail -f /var/log/nginx/access.log
ls -ltr /var/log/httpd 
sudo cat ls -ltr /var/log/httpd 
sudo cat ls -ltr /var/log/httpd/access.log
tail -f ls -ltr /var/log/httpd/access.log
sudo vi /etc/httpd/conf/
search for index.html and change to index.php

systemctl restart httpd

# Update the db_conn.php file 
Check Terraform for the values
  username               = "project15"
  password               = "pblproject15"

systemctl restart httpd