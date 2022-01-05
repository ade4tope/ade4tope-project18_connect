resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.ig]


  tags = {
    Name            = "project-15-main-eip"
    Enviroment      = "production"
    Owner-Email     = var.owner_email
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = module.networking.private_subnet_1_id
  depends_on    = [aws_internet_gateway.ig]


  tags = {
    Name            = "project-15-main-nat"
    Enviroment      = "production"
    Owner-Email     = var.owner_email
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }
}