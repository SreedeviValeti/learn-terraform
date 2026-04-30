output "audit_log_buckets" {
  description = "count creates a list - note the [0] and [1] indexes"
  value       = [for b in aws_s3_bucket.audit_logs : b.bucket]
}

output "claims_buckets" {
  description = "for_each creates a map - note the dev/staging/prod keys"
  value       = { for k, b in aws_s3_bucket.claims : k => b.bucket }
}

output "protected_archive_bucket" {
  value = aws_s3_bucket.claims_archive.bucket
}