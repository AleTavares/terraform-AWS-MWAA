#------------------------------------
# ##### Cria o Ambiente de MWAA #####
#------------------------------------
resource "aws_mwaa_environment" "mwaa" {
  airflow_configuration_options = {
    "core.default_task_retries" = 16
    "core.parallelism"          = 1
  }
  webserver_access_mode = "PUBLIC_ONLY"
  dag_s3_path           = "dags/"

  execution_role_arn = aws_iam_role.execute_role_mwaa.arn
  name               = var.name

  network_configuration {
    security_group_ids = [aws_security_group.mwaa.id]
    subnet_ids         = aws_subnet.private[*].id
  }

  source_bucket_arn = aws_s3_bucket.bucket.arn
}
