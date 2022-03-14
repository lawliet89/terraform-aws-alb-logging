output "arn" {
  description = "ARN of the logging bucket"
  value       = aws_s3_bucket.access_logs.arn
}

output "name" {
  description = "Name of the logging bucket"
  value       = aws_s3_bucket.access_logs.bucket
}
