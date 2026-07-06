resource "aws_s3_bucket" "rnm_data" {
  bucket = "rnm-enterprise-financial-vault"

  # ✅ Public access removed by Gatekeeper Agent
  # acl  = "public-read"

  tags = {
    Environment = "Production"
  }
}

resource "aws_s3_bucket_public_access_block" "rnm_data_privacy" {
  bucket                  = aws_s3_bucket.rnm_data.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "rnm_data_encryption" {
  bucket = aws_s3_bucket.rnm_data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}