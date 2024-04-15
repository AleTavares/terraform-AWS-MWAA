#-----------------------------------------
# ############## Roule MWAA ##############
#-----------------------------------------
resource "aws_iam_role" "execute_role_mwaa" {
  name               = "airflow-execution-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.mwaa_assume.json
  tags = {
    nane = "mwaa-role"
  }
}

resource "aws_iam_role_policy" "role-policy" {
  name   = "airflow-execution-role-policy"
  role   = aws_iam_role.execute_role_mwaa.id
  policy = data.aws_iam_policy_document.execution_role_policy.json
}
