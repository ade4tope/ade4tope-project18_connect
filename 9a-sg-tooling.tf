# security group for alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "tooling-sg" {
  name        = "p15-tooling-sg"
  vpc_id      = module.networking.vpc_id
  description = "tooling SG"


  tags = {
    Name            = "p15-tooling-sg"
    Enviroment      = "production"
    Owner-Email     = var.owner_email
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }

}