
# ---------------------------------------------------------------------------------------------------------------------
# MWAA Security Group
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_security_group" "mwaa" {
  name_prefix = "mwaa-"
  description = "Security group for MWAA environment"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group_rule" "mwaa_sg_inbound_vpn" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] #[aws_vpc.vpc.cidr_block]
  security_group_id = aws_security_group.mwaa.id
  description       = "VPN Access for Airflow UI"
}
