# security group for alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "int-alb-sg" {
  name        = "p15-int-alb-sg"
  vpc_id      = module.networking.vpc_id
  description = "Internal SG ALB"


  tags = {
    Name            = "p15-int-alb-sg"
    Enviroment      = "production"
    Owner-Email     = var.owner_email
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }

}