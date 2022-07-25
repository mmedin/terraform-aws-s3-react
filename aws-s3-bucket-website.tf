provider "aws" {
  region = "us-east-1"
}

variable "bucket_name" {
  default = "a-react-app-in-s3"
}

resource "aws_s3_bucket" "react_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "react_bucket_acl" {
  bucket = aws_s3_bucket.react_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "react_bucket_policy" {
  bucket = aws_s3_bucket.react_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.react_bucket.arn,
          "${aws_s3_bucket.react_bucket.arn}/*",
        ]
      },
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "react_bucket_web_conf" {
  bucket = aws_s3_bucket.react_bucket.bucket
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "index.html"
  }
}

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.react_bucket_web_conf.website_endpoint
}
