variable "aws_region" {
  description = "Target region for deployment"
  type        = string
  default     = "ap-southeast-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of AZs to deploy subnets into"
  type        = list(string)
  default     = ["ap-southeast-1a", "ap-southeast-1b"]
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for outbound internet access from private subnets"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Environment tag (e.g., Dev, Prod, Lab)"
  type        = string
  default     = "Lab"
}