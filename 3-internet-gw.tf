resource "aws_internet_gateway" "ig" {
  vpc_id = module.networking.vpc_id

  tags = {
    Name            = "project-15-main-IG"
    Enviroment      = "production"
    Owner-Email     = "infradev@teadservices.com"
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }

}

