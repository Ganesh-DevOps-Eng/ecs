output "file_storage_bucket" {
  value = aws_s3_bucket.file_storage.bucket
}

output "frontend_bucket" {
  value = aws_s3_bucket.frontend.bucket
}

output "frontend_website_url" {
  value = aws_s3_bucket.frontend.website_endpoint
}
