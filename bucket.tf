resource "aws_s3_bucket" "bucket" {
  bucket = "${var.account_id}-${var.bucket_name}"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "dag" {
  depends_on = [aws_s3_bucket_versioning.versioning]
  for_each   = fileset("dags/", "**")
  bucket     = aws_s3_bucket.bucket.id
  key        = "dags/${each.value}"
  source     = "dags/${each.value}"
  etag       = filemd5("dags/${each.value}")
}

resource "aws_s3_bucket" "bucket_Glue" {
  bucket = "${var.account_id}-${var.bucket_name_glue}"
}

resource "aws_s3_object" "scripts_glue" {
  for_each = fileset("scripts/", "**")
  bucket   = aws_s3_bucket.bucket_Glue.id
  key      = "scripts/${each.value}"
  source   = "scripts/${each.value}"
  etag     = filemd5("scripts/${each.value}")
}
