output "alb_sg_id" {
  description = "Security Group ID for the Application Load Balancer"
  value       = aws_security_group.alb.id
}

output "flask_sg_id" {
  description = "Security Group ID for Flask application pods"
  value       = aws_security_group.flask.id
}

output "rds_sg_id" {
  description = "Security Group ID for RDS PostgreSQL"
  value       = aws_security_group.rds.id
}
