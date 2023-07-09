resource "aws_security_group" "allow_tls" {
  name        = "allow_alb_public_${var.ENV}"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.DEFAULT_VPC_ID

  ingress {
    description = "Allow 80 to all"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow 443 to all"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_alb_public_${var.ENV}"
  }
}