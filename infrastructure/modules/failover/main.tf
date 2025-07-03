resource "aws_cloudwatch_event_rule" "rds_failover" {
  name = "${var.prefix}-rds-failover"

  event_pattern = jsonencode({
    source        = ["aws.rds"]
    "detail-type" = ["RDS DB Instance Event"]
    detail = {
      EventCategories  = ["failover"]
      SourceIdentifier = [var.primary_db_id]
    }
  })
}

resource "aws_iam_role" "promote_role" {
  name               = "${var.prefix}-promote-replica-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume.json
}

data "aws_iam_policy_document" "lambda_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "promote_policy" {
  name = "${var.prefix}-promote-replica"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action   = ["rds:PromoteReadReplica"]
      Effect   = "Allow"
      Resource = var.replica_arn
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_promote" {
  role       = aws_iam_role.promote_role.name
  policy_arn = aws_iam_policy.promote_policy.arn
}

resource "aws_lambda_function" "promote" {
  function_name = "${var.prefix}-promote-replica"
  s3_bucket     = var.lambda_s3_bucket
  s3_key        = var.lambda_s3_key
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  role          = aws_iam_role.promote_role.arn
  environment {
    variables = { REPLICA_ID = var.replica_id }
  }
}

resource "aws_cloudwatch_event_target" "to_lambda" {
  rule = aws_cloudwatch_event_rule.rds_failover.name
  arn  = aws_lambda_function.promote.arn
}

resource "aws_lambda_permission" "allow_event" {
  statement_id  = "AllowEvents"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.promote.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.rds_failover.arn
}
