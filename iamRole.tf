#Roule MWAA
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


# IAM Roule Glue
resource "aws_iam_role" "iam_glu_mwaa" {
  name               = "glue-airflow-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.glue_mwaa.json
  tags = {
    name = "glue-airflow-role"
  }
}

## Police liberação execução Glue
resource "aws_iam_role_policy_attachment" "glue_service" {
  role       = aws_iam_role.iam_glu_mwaa.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}
## Policy acesso s3 do 
resource "aws_iam_role_policy" "policyS3Glue" {
  name   = "s3Glue"
  role   = aws_iam_role.iam_glu_mwaa.id
  policy = data.aws_iam_policy_document.glue_role_policy.json
}
