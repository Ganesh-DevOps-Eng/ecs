resource "aws_s3_bucket" "file_storage" {
  bucket = "${var.project_name}-${var.env}-file-storage"

  tags = {
    Name        = "${var.project_name}-${var.env}-file-storage"
    Environment = var.env
  }
}

resource "aws_s3_bucket_versioning" "file_storage_versioning" {
  bucket = aws_s3_bucket.file_storage.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_public_access_block" "file_storage" {
  bucket = aws_s3_bucket.file_storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
