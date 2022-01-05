# security group for alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "datalayer-sg" {
  name        = "p15-datalayer-sg"
  vpc_id      = module.networking.vpc_id
  description = "Datalayer SG"


  tags = {
    Name            = "p15-datalayer-sg"
    Enviroment      = "production"
    Owner-Email     = var.owner_email
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }

}