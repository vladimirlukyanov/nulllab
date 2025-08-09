module "website-static-cloudfront-s3" {
  source  = "nulllogic/website-static-cloudfront-s3/aws"
  version = "v0.5.76"

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