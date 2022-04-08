data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "server_lb" {
  name   = "${var.stack_name}-server-lb"
  vpc_id = var.vpc_id != "" ? var.vpc_id : data.aws_vpc.default.id

  # Nomad HTTP API & UI.
  ingress {
    from_port   = 4646
    to_port     = 4646
    protocol    = "tcp"
    cidr_blocks = var.allowlist_ip
  }

  # Consul HTTP API & UI.
  ingress {
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
    cidr_blocks = var.allowlist_ip
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "client_lb" {
  name   = "${var.stack_name}-client-lb"
  vpc_id = var.vpc_id != "" ? var.vpc_id : data.aws_vpc.default.id

  # Fabio HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Fabio HTTP
  ingress {
    from_port   = 9999
    to_port     = 9999
    protocol    = "tcp"
    cidr_blocks = var.allowlist_ip
  }

  # Fabio Admin
  ingress {
    from_port   = 9998
    to_port     = 9998
    protocol    = "tcp"
    cidr_blocks = var.allowlist_ip
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "primary" {
  name   = var.stack_name
  vpc_id = var.vpc_id != "" ? var.vpc_id : data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowlist_ip
  }

  # Nomad
  ingress {
    from_port       = 4646
    to_port         = 4646
    protocol        = "tcp"
    cidr_blocks     = var.allowlist_ip
    security_groups = [aws_security_group.server_lb.id]
  }

  # Consul
  ingress {
    from_port       = 8500
    to_port         = 8500
    protocol        = "tcp"
    cidr_blocks     = var.allowlist_ip
    security_groups = [aws_security_group.server_lb.id]
  }

  # Fabio Admin
  ingress {
    from_port       = 9998
    to_port         = 9998
    protocol        = "tcp"
    security_groups = [aws_security_group.client_lb.id]
  }

  ingress {
    from_port       = 9999
    to_port         = 9999
    protocol        = "tcp"
    security_groups = [aws_security_group.client_lb.id]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.client_lb.id]
  }

  # Nomad dynamic port allocation range.
  ingress {
    from_port       = 20000
    to_port         = 32000
    protocol        = "tcp"
    security_groups = [aws_security_group.client_lb.id]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}