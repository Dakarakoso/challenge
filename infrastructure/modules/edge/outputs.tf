output "cloudfront_domain" {
  value = aws_cloudfront_distribution.crm.domain_name
}

output "hosted_zone_id" {
  value = aws_route53_zone.main.zone_id
}