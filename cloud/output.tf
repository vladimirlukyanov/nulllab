output "distribution" {
    value               = { 
        arn             = aws_cloudfront_distribution.cloudfront.arn
        domain_name     = aws_cloudfront_distribution.cloudfront.domain_name
        hosted_zone_id  = aws_cloudfront_distribution.cloudfront.hosted_zone_id
        id              = aws_cloudfront_distribution.cloudfront.id
    }
}
