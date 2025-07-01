output "repository_name" {
  value = aws_codecommit_repository.crm.repository_name
}

output "repository_url" {
  value = aws_codecommit_repository.crm.clone_url_http
}

output "pipeline_name" {
  value = aws_codepipeline.crm.name
}