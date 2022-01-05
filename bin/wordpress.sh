#!/bin/bash


sudo yum update -y
sudo yum install -y mysql git wget
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo yum install -y dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm

# this section is to install EFS util for mounting to the file system

git clone https://github.com/aws/efs-utils

cd ~/efs-utils

sudo yum install -y rpm-build

make rpm 

sudo yum install -y  ./build/amazon-efs-utils*rpm

mkdir /var/www/
sudo mount -t efs -o tls,accesspoint=fsap-01ded2ce9e83f393e fs-0de3eca94112794b7:/ /var/www/
yum install -y httpd 
systemctl start httpd
systemctl enable httpd
yum module reset php -y
yum module enable php:remi-7.4 -y
yum install -y php php-common php-mbstring php-opcache php-intl php-xml php-gd php-curl php-mysqlnd php-fpm php-json
systemctl start php-fpm
systemctl enable php-fpm
sudo dnf install wget
wget http://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
rm -rf latest.tar.gz
cp wordpress/wp-config-sample.php wordpress/wp-config.php
sudo
cp -R /home/ec2-user/wordpress/* /var/www/html/
sudo setenforce Permissive
sestatus
cd /var/www/html/
touch healthstatus
sudo curl -v localhost/healthstatus
sed -i "s/localhost/acs-database.cdqpbjkethv0.us-east-1.rds.amazonaws.com/g" wp-config.php 
sed -i "s/username_here/ACSadmin/g" wp-config.php 
sed -i "s/password_here/admin12345/g" wp-config.php 
sed -i "s/database_name_here/wordpressdb/g" wp-config.php 
chcon -t httpd_sys_rw_content_t /var/www/html/ -R

 # Configure App connectivity to the database 

mysql -h terraform-20220102120944616100000005.cuno0cvdscyv.us-east-1.rds.amazonaws.com -u project15 -p 

# Export the tooling_db_schema.sql
mysql -h terraform-20220102120944616100000005.cuno0cvdscyv.us-east-1.rds.amazonaws.com -u project15 -p    < tooling_db_schema.sql
PW - pblproject15