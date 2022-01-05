module "networking" {
  source = "./modules/networking"
}

module "dns" {
  source                = "./modules/route53"
  external_alb_dns_name = aws_lb.external-alb.dns_name
  external_alb_zone_id  = aws_lb.external-alb.zone_id
}

module "security_group" {
  source      = "./modules/security_groups"
  vpc_id      = module.networking.vpc_id
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}


module "eks" {
  source          = "terraform-aws-modules/eks/aws"

  cluster_version = "1.21"
  cluster_name    = "darey-cluster"
  vpc_id          = module.networking.vpc_id
  subnets         = [aws_subnet.PrivateSubnet-1.id, aws_subnet.PrivateSubnet-2.id]

  worker_groups = [
    {
      instance_type = "t2.micro"
      asg_max_size  = 5
    }
  ]
}