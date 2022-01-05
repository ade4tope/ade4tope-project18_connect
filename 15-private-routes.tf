# create private route table
resource "aws_route_table" "private-rtb" {
  vpc_id = module.networking.vpc_id

  tags = {
    Name            = "p15-Private-Route-Table"
    Enviroment      = "production"
    Owner-Email     = var.owner_email
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }
}

# create route for the private route table and attatch a nat gateway to it
resource "aws_route" "private-rtb-route" {
  route_table_id         = aws_route_table.private-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}


# associate all private subnets to the private route table
resource "aws_route_table_association" "private-subnets-assoc-1" {
  subnet_id      = aws_subnet.PrivateSubnet-1.id
  route_table_id = aws_route_table.private-rtb.id
}


resource "aws_route_table_association" "private-subnets-assoc-2" {
  subnet_id      = aws_subnet.PrivateSubnet-2.id
  route_table_id = aws_route_table.private-rtb.id
}

resource "aws_route_table_association" "private-subnets-assoc-3" {
  subnet_id      = aws_subnet.PrivateSubnet-3.id
  route_table_id = aws_route_table.private-rtb.id
}

resource "aws_route_table_association" "private-subnets-assoc-4" {
  subnet_id      = aws_subnet.PrivateSubnet-4.id
  route_table_id = aws_route_table.private-rtb.id
}