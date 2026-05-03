module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "cyber-leader-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-southeast-1a"]
  public_subnets  = ["10.0.1.0/24"] # Public Subnet
  private_subnets = ["10.0.2.0/24"] # Private Subnet

  enable_nat_gateway = true
  single_nat_gateway = true # Cost-effective for lab
  enable_vpn_gateway = false

  tags = {
    Project = "Cloud-Security-Lab"
  }
}

# Security Group to allow internal traffic
resource "aws_security_group" "internal_only" {
  name        = "internal-app-sg"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
