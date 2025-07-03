output "connection_arn" {
  description = "ARN of the CodeStar Connection to GitHub"
  value       = aws_codestarconnections_connection.github.arn
}