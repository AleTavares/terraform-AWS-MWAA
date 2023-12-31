resource "aws_iam_role" "iam_role" {
  name               = "airflow-execution-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.mwaa_assume.json
  tags = {
    nane = "mwaa-role"
  }
}

resource "aws_iam_role_policy" "role-policy" {
  name   = "airflow-execution-role-policy"
  role   = aws_iam_role.iam_role.id
  policy = data.aws_iam_policy_document.execution_role_policy.json
}
