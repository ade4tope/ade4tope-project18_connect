# security group for alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "bastion-sg" {
  name        = "p15-bastion-sg"
  vpc_id      = module.networking.vpc_id
  description = "Bastion SG"


  tags = {
    Name            = "p15-bastion-sg"
    Enviroment      = "production"
    Owner-Email     = var.owner_email
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }

}