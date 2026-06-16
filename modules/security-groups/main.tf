# ALB Security Group — faces the public internet
resource "aws_security_group" "alb" {
  name        = "${var.project_name}-${var.environment}-alb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS from internet"
    from_port   = 443 #tfsec:ignore:aws-ec2-no-public-ingress-sgr -- ALB is the public entry point
    to_port     = 443 #tfsec:ignore:aws-ec2-no-public-ingress-sgr -- ALB is the public entry point
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:aws-ec2-no-public-ingress-sgr -- ALB must accept public HTTPS traffic
  }

  ingress {
    description = "HTTP from internet - redirect to HTTPS only"
    from_port   = 80 #tfsec:ignore:aws-ec2-no-public-ingress-sgr -- ALB is the public entry point
    to_port     = 80 #tfsec:ignore:aws-ec2-no-public-ingress-sgr -- ALB is the public entry point
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:aws-ec2-no-public-ingress-sgr -- ALB must accept public HTTP traffic
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0 #tfsec:ignore:aws-ec2-no-public-egress-sgr -- Unrestricted egress acceptable for lab
    to_port     = 0 #tfsec:ignore:aws-ec2-no-public-egress-sgr -- Unrestricted egress acceptable for lab
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:aws-ec2-no-public-egress-sgr -- Unrestricted egress acceptable for lab
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-alb-sg"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Flask Security Group — only accepts traffic from ALB
resource "aws_security_group" "flask" {
  name        = "${var.project_name}-${var.environment}-flask-sg"
  description = "Security group for Flask application pods"
  vpc_id      = var.vpc_id

  ingress {
    description     = "App traffic from ALB only"
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0 #tfsec:ignore:aws-ec2-no-public-egress-sgr -- Unrestricted egress acceptable for lab
    to_port     = 0 #tfsec:ignore:aws-ec2-no-public-egress-sgr -- Unrestricted egress acceptable for lab
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:aws-ec2-no-public-egress-sgr -- Unrestricted egress acceptable for lab
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-flask-sg"
    Environment = var.environment
    Project     = var.project_name
  }
}

# RDS Security Group — only accepts traffic from Flask
resource "aws_security_group" "rds" {
  name        = "${var.project_name}-${var.environment}-rds-sg"
  description = "Security group for RDS PostgreSQL"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL from Flask only"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.flask.id]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0 #tfsec:ignore:aws-ec2-no-public-egress-sgr -- Unrestricted egress acceptable for lab
    to_port     = 0 #tfsec:ignore:aws-ec2-no-public-egress-sgr -- Unrestricted egress acceptable for lab
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:aws-ec2-no-public-egress-sgr -- Unrestricted egress acceptable for lab
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-rds-sg"
    Environment = var.environment
    Project     = var.project_name
  }
}
