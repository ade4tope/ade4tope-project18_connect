# security group for alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "wordpress-sg" {
  name        = "p15-wordpress-sg"
  vpc_id      = module.networking.vpc_id
  description = "wordpress SG"


  tags = {
    Name            = "p15-wordpress-sg"
    Enviroment      = "production"
    Owner-Email     = var.owner_email
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }

}