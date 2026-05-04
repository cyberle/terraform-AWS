resource "aws_s3_bucket" "app_data" {
  # checkov:skip=CKV_AWS_144: "Cross-region replication not required for lab"
  # checkov:skip=CKV_AWS_145: "Using default SSE-S3 encryption for now"
  
  bucket = "${var.environment}-${var.bucket_name_prefix}-${random_id.suffix.hex}"

  tags = {
    Name        = "AppDataStorage"
    Environment = var.environment
    Region      = var.aws_region
  }
}

# Enforce Versioning (Defensive Security Best Practice)
resource "aws_s3_bucket_versioning" "app_data_versioning" {
  bucket = aws_s3_bucket.app_data.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Encryption at Rest (Compliance Requirement)
resource "aws_s3_bucket_server_side_encryption_configuration" "app_data_encryption" {
  bucket = aws_s3_bucket.app_data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block Public Access (The "Golden Rule" of S3 Security)
resource "aws_s3_bucket_public_access_block" "app_data_block" {
  bucket = aws_s3_bucket.app_data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "random_id" "suffix" {
  byte_length = 4
}
