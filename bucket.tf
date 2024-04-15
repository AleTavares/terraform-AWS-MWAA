# Cria o Bucket de Armazenamento dos Artefatos do MWAA
resource "aws_s3_bucket" "bucket" {
  bucket = "${local.account_id}-${var.bucket_name}"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
## Pasta armazenamento de
## Copia todas as Dags que estiverem na pasta dags deste repositorio para a pasta das DEGs do MWAA
resource "aws_s3_object" "dag" {
  depends_on = [aws_s3_bucket_versioning.versioning]
  for_each   = fileset("dags/", "**")
  bucket     = aws_s3_bucket.bucket.id
  key        = "dags/${each.value}"
  source     = "dags/${each.value}"
  etag       = filemd5("dags/${each.value}")
}
