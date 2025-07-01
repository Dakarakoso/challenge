variable "domain_name" {
  description = "Domain name for the application"
  type        = string
}

variable "alb_dns_name" {
  description = "ALB DNS name"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN"
  type        = string
}

variable "waf_acl_arn" {
  description = "WAF ACL ARN"
  type        = string
}