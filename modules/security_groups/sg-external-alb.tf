# security group for alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "ext-alb-sg" {
  name        = "p15-ext-alb-sg"
  vpc_id      = var.vpc_id
  description = "External ALB SG"


  tags = {
    Name            = "p15-ext-alb-sg"
    Enviroment      = "production"
    Owner-Email     = var.owner_email
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }

}


resource "aws_security_group_rule" "allow_all_ingress_port80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ext-alb-sg.id
}


resource "aws_security_group_rule" "allow_all_ext_alb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ext-alb-sg.id
}

