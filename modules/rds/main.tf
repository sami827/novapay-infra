#Handles DB Subnet Groups

resource "aws_db_subnet_group" "novapay" {

  name        = "${var.project_name}-${var.environment}-db-subnet-group"
  description = "DB Subnet Group for ${var.project_name}-${var.environment}"
  subnet_ids  = var.private_subnet_ids

  tags = {
    Name        = "${var.project_name}-${var.environment}-db-subnet-group"
    Environment = var.environment
    Project     = var.project_name
  }

}

resource "aws_db_parameter_group" "novapay" {
  family      = "postgres17"
  name        = "${var.project_name}-${var.environment}-db-parameter-group"
  description = "Custom parameter group for ${var.project_name}-${var.environment}"

  tags = {
    Name        = "${var.project_name}-${var.environment}-db-parameter-group"
    Environment = var.environment
    Project     = var.project_name
  }

}


resource "aws_db_instance" "novapay" {

  identifier             = "${var.project_name}-${var.environment}-db"
  engine                 = "postgres"
  engine_version         = "17"
  instance_class         = var.db_instance_class
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.novapay.name
  parameter_group_name   = aws_db_parameter_group.novapay.name
  vpc_security_group_ids = [var.rds_sg_id]
  multi_az               = var.multi_az
  skip_final_snapshot    = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-db-instance-group"
    Environment = var.environment
    Project     = var.project_name
  }

}
