resource "aws_s3_bucket" "cur" {
  bucket        = var.cur_s3_bucket
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "cur" {
  bucket = aws_s3_bucket.cur.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "cur" {
  bucket = aws_s3_bucket.cur.id

  rule {
    id     = "expire-old-cur"
    status = "Enabled"
    filter {
      prefix = ""
    }
    expiration {
      days = 365
    }
  }
}

resource "aws_cur_report_definition" "daily" {
  report_name                = "${var.prefix}-daily-cur"
  time_unit                  = "DAILY"
  format                     = "textORcsv"
  compression                = "GZIP"
  additional_schema_elements = ["RESOURCES"]
  s3_bucket                  = aws_s3_bucket.cur.bucket
  s3_region                  = var.region
  s3_prefix                  = "cur-reports/"
  report_versioning          = "CREATE_NEW_REPORT"
}

resource "aws_sns_topic" "cost_alerts" {
  name = "${var.prefix}-cost-alerts"
}

resource "aws_budgets_budget" "monthly" {
  name         = "${var.prefix}-monthly-budget"
  budget_type  = "COST"
  limit_amount = var.monthly_budget_limit
  limit_unit   = "JPY"
  time_unit    = "MONTHLY"

  cost_types {
    include_tax          = true
    include_subscription = true
    use_blended          = false
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    notification_type          = "ACTUAL"
    threshold                  = var.budget_threshold_amount
    threshold_type             = "PERCENTAGE"
    subscriber_email_addresses = [var.alert_email]
  }

  depends_on = [aws_sns_topic.cost_alerts]
}


resource "aws_cloudwatch_event_rule" "cost_anomaly" {
  name = "${var.prefix}-cost-anomaly-rule"
  event_pattern = jsonencode({
    source        = ["aws.costexplorer"],
    "detail-type" = ["Cost Anomaly Detection Notification"]
  })
}

resource "aws_cloudwatch_event_target" "cost_anomaly_to_sns" {
  rule = aws_cloudwatch_event_rule.cost_anomaly.name
  arn  = aws_sns_topic.cost_alerts.arn
}

data "aws_iam_policy_document" "events_to_sns" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.cost_alerts.arn]
    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudwatch_event_rule.cost_anomaly.arn]
    }
  }
}

resource "aws_sns_topic_policy" "cost_alerts_policy" {
  arn    = aws_sns_topic.cost_alerts.arn
  policy = data.aws_iam_policy_document.events_to_sns.json
}
