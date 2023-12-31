output "end_point_mwaa" {
  description = "End Point MWAA"
  value       = aws_mwaa_environment.mwaa.webserver_url
}
