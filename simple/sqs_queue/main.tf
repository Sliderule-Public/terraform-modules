resource "aws_sqs_queue" "terraform_queue" {
  name                      = substr("${var.company_name}-${var.environment}-${var.name}", 0, 64)
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  sqs_managed_sse_enabled   = true
  tags                      = var.tags
  redrive_policy            = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 4
  })
}

resource "aws_sqs_queue" "dlq" {
  name                      = substr("dlq-${var.company_name}-${var.environment}-${var.name}", 0, 64)
  message_retention_seconds = 1209600
  redrive_allow_policy      = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [
      aws_sqs_queue.terraform_queue.arn
    ]
  })
}