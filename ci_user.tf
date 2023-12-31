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
resource "aws_iam_user" "app_user" {
  name = "appusr_airflow_ci"
  path = "/"
  tags = {
    Name = "PrivateSubnet"
  }
}

resource "aws_iam_access_key" "access_key" {
  user = aws_iam_user.app_user.name
}

resource "aws_iam_user_policy" "user_policy" {
  name   = "airflow_ci_policy"
  user   = aws_iam_user.app_user.name
  policy = data.aws_iam_policy_document.ci_user_policy.json
}

output "ci_access_key" {
  value = aws_iam_access_key.access_key.id
}

output "ci_secret_key" {
  value     = aws_iam_access_key.access_key.secret
  sensitive = true
}