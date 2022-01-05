#External Load balancer for reverse proxy nginx
#---------------------------------

resource "aws_lb" "external-alb" {
  name            = "prj-15-external-alb"
  internal        = false
  security_groups = [module.security_group.external_alb_sg_id]

  subnets = [module.networking.private_subnet_1_id,
  aws_subnet.PublicSubnet-2.id]

  tags = {
    Name            = "project-15-external-alb"
    Enviroment      = "production"
    Owner-Email     = "infradev@teadservices.com"
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }

  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

#--- create a listener for the load balancer

resource "aws_lb_listener" "nginx-listner" {
  load_balancer_arn = aws_lb.external-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx-tgt.arn
  }
}


#--- create a target group for the external load balancer
resource "aws_lb_target_group" "nginx-tgt" {
  name        = "prj-15-nginx-tgt"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.networking.vpc_id
  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}



