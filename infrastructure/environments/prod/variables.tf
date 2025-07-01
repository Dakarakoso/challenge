variable "vpc_cidr" {
    description = "VPC CIDR block"
    type = string
}

variable "public_subnets" {
    description = "Public subnets"
    type = list(string)
}

variable "private_subnets" {
    description = "Private subnets"
    type = list(string)
}

variable "azs" {
    description = "Availability zones"
    type = list(string)
}

variable "acm_certificate_arn" {
    description = "ACM certificate ARN"
    type = string
}

variable "account_id" {
    description = "AWS account ID"
    type = string
}

variable "region" {
    description = "AWS region"
    type = string
}
