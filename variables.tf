variable "region" {
  description = "Região onde os recursos serão criados na Azure"
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  description = "ID da conta na AWS"
  type        = string
  default     = "353818015911"
}

variable "bucket_name_glue" {
  description = "Nome do Bucket de Scripts Glue"
  type        = string
  default     = "glue-jobs"
}

variable "bucket_name" {
  description = "Nome do Bucket de Configuração do MWAA"
  type        = string
  default     = "mwaa"
}

variable "name" {
  description = "Nome do recurso"
  type        = string
  default     = "teste-airflow"

}

variable "kms_key_arn" {
  description = "Arn do KMS"
  type        = string
  default     = null
}


########## var rede

variable "cidr_block" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_blocks" {
  default     = ["10.0.0.0/24", "10.0.2.0/24"]
  type        = list(any)
  description = "List of public subnet CIDR blocks"
}

variable "private_subnet_cidr_blocks" {
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
  type        = list(any)
  description = "List of private subnet CIDR blocks"
}