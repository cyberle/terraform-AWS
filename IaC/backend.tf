terraform {
  backend "s3" {
    bucket         = "tfstate-019734645993-ap-southeast-1-an" # The bucket you created in Phase 1
    key            = "dev/cyber-lab.tfstate"           # Where the file will sit in the bucket
    region         = "ap-southeast-1"
    encrypt        = true
    #dynamodb_table = "terraform-state-lock"            # For locking
  }
}
