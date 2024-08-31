module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.0"

  name = "main"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.0.0/19", "10.0.32.0/19"]
  public_subnets  = ["10.0.64.0/19", "10.0.96.0/19"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/cluster/fighters" = "shared"
    "kubernetes.io/role/elb"         = "1"
    "Name"                           = "main-public-subnet"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/fighters" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
    "Name"                            = "main-private-subnet"
  }

  map_public_ip_on_launch = true  # Enable auto-assign public IP for public subnets

  tags = {
    Environment = "staging"
  }
}
