#----------------------------------------
# ############## Role MWAA ##############
#----------------------------------------
data "aws_iam_policy_document" "mwaa_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["airflow.amazonaws.com"]
    }

    principals {
      type        = "Service"
      identifiers = ["airflow-env.amazonaws.com"]
    }

    principals {
      type        = "Service"
      identifiers = ["batch.amazonaws.com"]
    }

    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "execution_role_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    resources = [
      "arn:aws:airflow:${var.region}:${var.account_id}:environment/${var.name}",
    ]
    actions = [
      "airflow:PublishMetrics"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "iam:GetRole",
      "iam:PassRole"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "glue:Get*",
      "glue:CreateJob",
      "glue:StartJobRun"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    effect  = "Deny"
    actions = ["s3:ListAllMyBuckets"]
    resources = [
      "${aws_s3_bucket.bucket.arn}",
      "${aws_s3_bucket.bucket.arn}/*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject*",
      "s3:GetBucket*",
      "s3:List*"
    ]
    resources = [
      "${aws_s3_bucket.bucket.arn}",
      "${aws_s3_bucket.bucket.arn}/*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:GetLogRecord",
      "logs:GetLogGroupFields",
      "logs:GetQueryResults"
    ]
    resources = [
      "arn:aws:logs:${var.region}:${var.account_id}:log-group:airflow-${var.name}-*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:DescribeLogGroups"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricData"
    ]
    resources = [
      "*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage",
      "sqs:SendMessage"
    ]
    resources = [
      "arn:aws:sqs:${var.region}:*:airflow-celery-*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:GenerateDataKey*",
      "kms:Encrypt"
    ]
    not_resources = ["arn:aws:kms:*:${var.account_id}:key/*"]
    condition {
      test     = "StringLike"
      values   = var.kms_key_arn != null ? ["s3.${var.region}.amazonaws.com"] : ["sqs.${var.region}.amazonaws.com"]
      variable = "kms:ViaService"
    }
  }
}

#----------------------------------------------------------------------
# ############## Policy de liberação de Execução do Glue ##############
#----------------------------------------------------------------------
data "aws_iam_policy_document" "glue_mwaa" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "glue_role_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    resources = [
        "arn:aws:s3:::${var.account_id}-${var.bucket_name_glue}/*",
        "arn:aws:s3:::${var.account_id}-${var.bucket_name_glue}"    ]
    actions = [
      "s3:Get*",
      "s3:List*",
      "s3:*Object*"    ]
  }
}

#--------------------------------------------------
# ############## Policy Usuario MWAA ##############
#--------------------------------------------------
data "aws_iam_policy_document" "ci_user_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject*",
      "s3:GetBucket*",
      "s3:List*",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:GetEncryptionConfiguration",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.bucket.bucket_domain_name}",
      "arn:aws:s3:::${aws_s3_bucket.bucket.bucket_domain_name}/*"
    ]
  }
}

data "aws_iam_policy_document" "AmazonMWAAAirflowCliAccess" {
  statement {
    effect = "Allow"
    actions = [
      "airflow:CreateCliToken"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "AmazonMWAAFullConsoleAccess" {
  statement {
    effect = "Allow"
    actions = [
      "iam:CreateServiceLinkedRole"
    ]
    resources = [
      "arn:aws:iam::*:role/aws-service-role/airflow.amazonaws.com/AWSServiceRoleForAmazonMWAA",
      "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
    ]
  }
}

data "aws_iam_policy_document" "AmazonMWAAWebServerAccess" {
  statement {
    effect = "Allow"
    actions = [
      "airflow:CreateWebLoginToken"
    ]
    resources = [
      "arn:aws:airflow:us-east-1:353818015911:role/${aws_mwaa_environment.mwaa.name}/Public"
    ]
  }
}
