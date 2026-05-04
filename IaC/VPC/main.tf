module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

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
