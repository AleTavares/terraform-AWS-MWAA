resource "aws_iam_user" "mwaaUser" {
  name          = "tavares"
  path          = "/"
  force_destroy = true
  tags = {
    Name = "userModelo"
  }
}

resource "aws_iam_user_login_profile" "mwaa_user_policy" {
  user                    = aws_iam_user.mwaaUser.name
  password_reset_required = true
  pgp_key                 = "keybase:some_person_that_exists"
}

# resource "aws_iam_access_key" "access_key" {
#   user = aws_iam_user.app_user.name
# }

resource "aws_iam_user_policy" "user_policy" {
  name   = "airflow_ci_policy"
  user   = aws_iam_user.mwaaUser.name
  policy = data.aws_iam_policy_document.ci_user_policy.json
}

resource "aws_iam_user_policy" "MWAAAirflowCliAccess" {
  name   = "AmazonMWAAAirflowCliAccess"
  user   = aws_iam_user.mwaaUser.name
  policy = data.aws_iam_policy_document.AmazonMWAAAirflowCliAccess.json
}

resource "aws_iam_user_policy" "MWAAFullConsoleAccess" {
  name   = "AmazonMWAAFullConsoleAccess"
  user   = aws_iam_user.mwaaUser.name
  policy = data.aws_iam_policy_document.AmazonMWAAFullConsoleAccess.json
}

resource "aws_iam_user_policy" "MWAAWebServerAccess" {
  name   = "AmazonMWAAWebServerAccess"
  user   = aws_iam_user.mwaaUser.name
  policy = data.aws_iam_policy_document.AmazonMWAAWebServerAccess.json
}
# output "ci_access_key" {
#   value = aws_iam_access_key.access_key.id
# }

# output "ci_secret_key" {
#   value     = aws_iam_access_key.access_key.secret
#   sensitive = true
# }