resource "aws_db_subnet_group" "prj-15-rds-subnet-group" {
  name = "prj-15-rds-subnet-group"
  subnet_ids = [aws_subnet.PrivateSubnet-3.id,
  aws_subnet.PrivateSubnet-4.id]

  tags = {
    Name            = "prj-15-rds-subnet-group"
    Enviroment      = "production"
    Owner-Email     = "infradev@teadservices.com"
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }

}

# create the RDS instance with the subnets group
resource "aws_db_instance" "prj-15-RDS" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "project15DB"
  username               = "project15"
  password               = "pblproject15"
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.prj-15-rds-subnet-group.name
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.datalayer-sg.id]
  multi_az               = "true"
}
