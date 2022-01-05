
################# Outputs ################
output "vpc_id" {
  value = module.networking.vpc_id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.ig.id
}

output "external-alb-securtygroup_id" {
  value = module.security_group.external_alb_sg_id
}


