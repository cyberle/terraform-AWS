output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = aws_s3_bucket.app_data.id
}

output "s3_bucket_arn" {
  description = "The ARN of the bucket. Useful for IAM policies."
  value       = aws_s3_bucket.app_data.arn
}

output "s3_bucket_region" {
  description = "The region the bucket resides in."
  value       = aws_s3_bucket.app_data.region
}

output "s3_bucket_domain_name" {
  description = "The bucket domain name."
  value       = aws_s3_bucket.app_data.bucket_domain_name
}
