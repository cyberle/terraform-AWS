module "vpc" {
  #source  = "terraform-aws-modules/vpc/aws"
  #version = "5.0.0"
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=26c38a66f12e7c6c93b6a2ba127ad68981a48671"  # commit hash of version 5.0.0

  azs = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  # Security best practice: Internal-only for this lab
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = true
  

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

# Security Group to allow internal traffic
resource "aws_security_group" "internal_only" {
  # checkov:skip=CKV2_AWS_5: "SG will be attached to EC2 instances in the next deployment phase"
  # checkov:skip=CKV_AWS_104: "Inbound/Outbound restricted to 443; global egress allowed for NAT"
  name        = "${var.environment}-app-sg"
  description = "SG with NAT Gateway outbound access"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow HTTPS from internal network"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "Allow HTTPS outbound for API calls and updates"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-app-sg"
    Environment = var.environment
  }
}
