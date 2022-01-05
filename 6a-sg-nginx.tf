# security group for alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "nginx-sg" {
  name        = "p15-nginx-sg"
  vpc_id      = module.networking.vpc_id
  description = "Nginx SG"


  tags = {
    Name            = "p15-nginx-sg"
    Enviroment      = "production"
    Owner-Email     = var.owner_email
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }

}