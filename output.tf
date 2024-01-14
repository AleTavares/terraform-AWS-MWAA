#--------------------------------------------------
# ############## Exibe a URL do MWAA ##############
#--------------------------------------------------

output "end_point_mwaa" {
  description = "End Point MWAA"
  value       = aws_mwaa_environment.mwaa.webserver_url
}

# output "password" {
#   description = "Senha Usuario: "
#   value       = aws_iam_user_login_profile.mwaa_user_policy.encrypted_password
# }
