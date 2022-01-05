

resource "aws_subnet" "PublicSubnet-2" {
  vpc_id                  = module.networking.vpc_id
  cidr_block              = "100.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name            = "PublicSubnet-2"
    Enviroment      = "production"
    Owner-Email     = var.owner_email
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }

}


resource "aws_subnet" "PrivateSubnet-1" {
  vpc_id                  = module.networking.vpc_id
  cidr_block              = "100.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags = {
    Name            = "PrivateSubnet-1"
    Enviroment      = "production"
    Owner-Email     = var.owner_email
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }

}


resource "aws_subnet" "PrivateSubnet-2" {
  vpc_id                  = module.networking.vpc_id
  cidr_block              = "100.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags = {
    Name            = "PrivateSubnet-2"
    Enviroment      = "production"
    Owner-Email     = var.owner_email
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }

}

resource "aws_subnet" "PrivateSubnet-3" {
  vpc_id                  = module.networking.vpc_id
  cidr_block              = "100.0.5.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1c"

  tags = {
    Name            = "PrivateSubnet-3"
    Enviroment      = "production"
    Owner-Email     = var.owner_email
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }

}


resource "aws_subnet" "PrivateSubnet-4" {
  vpc_id                  = module.networking.vpc_id
  cidr_block              = "100.0.6.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1d"

  tags = {
    Name            = "PrivateSubnet-4"
    Enviroment      = "production"
    Owner-Email     = var.owner_email
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }

}

