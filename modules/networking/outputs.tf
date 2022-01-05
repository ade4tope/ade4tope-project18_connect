output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet_1_id" {
  value = aws_subnet.PublicSubnet-1.id
}