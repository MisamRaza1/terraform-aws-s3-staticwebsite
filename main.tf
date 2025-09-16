terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.13.0"
    }
  }

}
resource "random_id" "rand_id" {
  byte_length = 7
}

provider "aws" {
  # Configuration options
  region = "eu-north-1"
}
resource "aws_s3_bucket" "mybucket" {
  bucket = "staticwebbucket${random_id.rand_id.hex}"
  tags = {
    Name = "Static Website Bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "mywebapp" {
  bucket = aws_s3_bucket.mybucket.id
  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid       = "PublicReadGetObject",
          Effect    = "Allow",
          Principal = "*",
          Action    = "s3:GetObject"
          Resource  = "arn:aws:s3:::${aws_s3_bucket.mybucket.id}/*"

        }
      ]
    }
  )
}
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.mybucket.id

  index_document {
    suffix = "index.html"
  }
}
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.mybucket.bucket
  source       = "./index.html"
  key          = "index.html"
  content_type = "text/html"
}
resource "aws_s3_object" "style_css" {
  bucket       = aws_s3_bucket.mybucket.bucket
  source       = "./style.css"
  key          = "style.css"
  content_type = "text/css"
}

output "website_url" {
  value = aws_s3_bucket_website_configuration.example.website_endpoint
}
