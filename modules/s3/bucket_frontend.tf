resource "aws_s3_bucket" "frontend" {
  bucket = "${var.project_name}-${var.env}-frontend"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Name        = "${var.project_name}-${var.env}-frontend"
    Environment = var.env
  }
}

resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
