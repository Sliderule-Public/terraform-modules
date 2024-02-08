data "aws_iam_policy_document" "assume_role" {
  count = var.deploy_cross_region_read_replica == true ? 1 : 0
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "replication" {
  count              = var.deploy_cross_region_read_replica == true ? 1 : 0
  name               = "${var.company_name}-${var.environment}-${var.region}-${var.bucket_name}-crr"
  assume_role_policy = data.aws_iam_policy_document.assume_role[0].json
}

data "aws_iam_policy_document" "replication" {
  count = var.deploy_cross_region_read_replica == true ? 1 : 0
  statement {
    effect = "Allow"

    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket",
    ]

    resources = [aws_s3_bucket.bucket_main.arn]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
    ]

    resources = ["${aws_s3_bucket.bucket_main.arn}/*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
    ]

    resources = ["${aws_s3_bucket.destination[0].arn}/*"]
  }
}

resource "aws_iam_policy" "replication" {
  count  = var.deploy_cross_region_read_replica == true ? 1 : 0
  name   = "${var.company_name}-${var.environment}-${var.bucket_name}-crr"
  policy = data.aws_iam_policy_document.replication[0].json
}

resource "aws_iam_role_policy_attachment" "replication" {
  count      = var.deploy_cross_region_read_replica == true ? 1 : 0
  role       = aws_iam_role.replication[0].name
  policy_arn = aws_iam_policy.replication[0].arn
}

resource "aws_s3_bucket" "destination" {
  count    = var.deploy_cross_region_read_replica == true ? 1 : 0
  provider = aws.cross_region_replication
  bucket   = "${var.company_name}-${var.environment}-${var.replication_region}-${var.bucket_name}-crr"
}

resource "aws_s3_bucket_versioning" "destination" {
  count    = var.deploy_cross_region_read_replica == true ? 1 : 0
  provider = aws.cross_region_replication
  bucket   = aws_s3_bucket.destination[0].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "replication" {
  count      = var.deploy_cross_region_read_replica == true ? 1 : 0
  # Must have bucket versioning enabled first??
  depends_on = [aws_s3_bucket_versioning.source, aws_s3_bucket_versioning.destination]

  role   = aws_iam_role.replication[0].arn
  bucket = aws_s3_bucket.bucket_main.id

  rule {
    id = "main"

    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.destination[0].arn
      storage_class = "STANDARD"
    }
  }
}