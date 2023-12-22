// Terraform beat AWS CDK, let's go (╯°□°)╯︵ ┻━┻

resource "aws_s3_bucket" "website" {
  provider = aws.main
  bucket   = variable.bucket

  lifecycle {
    prevent_destroy = false
  }
}

#------------------------------------------------------------------------------
# CloudFront Origin Access Identity
#------------------------------------------------------------------------------
resource "aws_cloudfront_origin_access_identity" "cloudfront_oai" {
  provider = aws.main
  comment  = "OAI to restrict access to AWS S3 content"
}

#------------------------------------------------------------------------------
# CloudFront Distribution
#------------------------------------------------------------------------------
resource "aws_cloudfront_distribution" "cloudfront" {
  provider = aws.main

  origin {
    domain_name = variable.domain
    origin_id   = variable.domain

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["SSLv3", "TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  price_class     = "PriceClass_200"
  enabled         = true
  is_ipv6_enabled = true

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.website.bucket
    compress         = true

    min_ttl     = 31536000
    max_ttl     = 31536000
    default_ttl = 31536000

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    /*
    lambda_function_association {
      event_type   = "viewer-request"
      lambda_arn   = aws_lambda_function.short_redirect.qualified_arn
      include_body = false
    }
*/
    viewer_protocol_policy = "allow-all"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}
