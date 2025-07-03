variable "prefix" {
  type        = string
  description = "Name prefix for failover resources"
}
variable "primary_db_id" {
  type        = string
  description = "The ID of the primary RDS instance to watch for failover"
}
variable "replica_id" {
  type        = string
  description = "The ID of the read-replica to promote"
}
variable "replica_arn" {
  type        = string
  description = "The ARN of the read-replica for IAM policy"
}
variable "lambda_s3_bucket" {
  type        = string
  description = "S3 bucket holding the Lambda zip"
}
variable "lambda_s3_key" {
  type        = string
  description = "S3 object key for the Lambda zip"
}
