#!/bin/bash

# nginx userdata

sudo yum update -y
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo yum install -y dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm
sudo yum install -y nginx git
sudo rm /etc/nginx/nginx.conf
sudo cat <<EOF >>/etc/nginx/nginx.conf
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    
    default_type        application/octet-stream;

    include /etc/nginx/conf.d/*.conf;

     server {
        listen       80;
        root          /var/www/html;
        server_name  *.teadservices.com;
        
        location /healthstatus {
        access_log off;
        return 200;
       }
    
         
        location / {
            proxy_set_header             Host $host;
            proxy_pass                   http://internal-prj-15-internal-alb-738996055.us-east-1.elb.amazonaws.com; 
           }
    }
}

EOF
sudo mkdir -p /var/www/html
sudo touch /var/www/html/healthstatus
sudo systemctl restart nginx
sudo systemctl enable nginx