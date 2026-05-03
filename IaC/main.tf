module "vpc_infrastructure" {
  source = "./VPC"
  # You can pass variables from the root to the child here
  #vpc_name = "cyber-lab-vpc"
}

module "s3_storage" {
  source = "./S3"
}
# Triggering security scan
