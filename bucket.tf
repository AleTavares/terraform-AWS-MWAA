# Bucket MWAA
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.account_id}-${var.bucket_name}"
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

# Cria um Bucket para armazernar os scripts do Glue
resource "aws_s3_bucket" "bucket_Glue" {
  bucket = "${var.account_id}-${var.bucket_name_glue}"
}
## Copia os scripts de Glue da Pasta Scripts deste repositorio para a pasta de Scripts do Bucket criado pro Glue
resource "aws_s3_object" "scripts_glue" {
  for_each = fileset("scripts/", "**")
  bucket   = aws_s3_bucket.bucket_Glue.id
  key      = "scripts/${each.value}"
  source   = "scripts/${each.value}"
  etag     = filemd5("scripts/${each.value}")
}
