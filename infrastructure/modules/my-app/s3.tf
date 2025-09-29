#S3 bucket to host frontend
resource "aws_s3_bucket" "fr-bucket" {
  bucket = local.bucket_name

}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.fr-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.fr-bucket.id
  policy = data.aws_iam_policy_document.iam-policy-1.json
}

data "aws_iam_policy_document" "iam-policy-1" {
  statement {
    sid     = "AllowOAIRead"
    effect  = "Allow"
    actions = ["S3:GetObject"]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.fr-bucket.bucket}",
      "arn:aws:s3:::${aws_s3_bucket.fr-bucket.bucket}/*",
    ]
    principals {
      type        = "CanonicalUser"
      identifiers = [aws_cloudfront_origin_access_identity.my_oai.s3_canonical_user_id]
    }
  }
}

resource "aws_s3_bucket_website_configuration" "bucket" {
  bucket = aws_s3_bucket.fr-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}
