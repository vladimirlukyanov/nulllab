module "website-static-cloudfront-s3" {
  source  = "nulllogic/website-static-cloudfront-s3/aws"
  version = "v0.6.33"

  enable = {
    s3 = {
      index_html = false
    }
  }

  s3 = {
    bucket  = "nulllab.net"
  }

  route53 = {
    domain = "nulllab.net"
    txt_record_multiple = [var.google_site_verification]
  }

  cloudfront = {
    root = {
      default_object = "index.html"
      price_class    = "PriceClass_200"
    },
    cache_behavior = {
      min_ttl     = 31536000
      max_ttl     = 31536000
      default_ttl = 31536000
    },
    content_security_policy = "frame-src youtube.com www.youtube.com www.youtube-nocookie.com; frame-ancestors 'none'; default-src 'none'; img-src * data:; script-src 'self' 'unsafe-inline' www.youtube.com www.youtube-nocookie.com; style-src 'self' 'unsafe-inline'; object-src 'none' ; manifest-src 'self'"
  }

  providers = {
    aws.main         = aws.main
    aws.acm_provider = aws.acm_provider
  }

  tags = {
    Project     = "nulllab.net"
    Environment = "dev"
    Terraform   = "true"
  }
}