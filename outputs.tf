output "vpc_id" {
  description = "NovaPay VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = [aws_subnet.public_az1.id, aws_subnet.public_az2.id]
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = [aws_subnet.private_az1.id, aws_subnet.private_az2.id]
}

output "alb_sg_id" {
  description = "ALB Security Group ID"
  value       = module.security_groups.alb_sg_id
}

output "flask_sg_id" {
  description = "Flask Security Group ID"
  value       = module.security_groups.flask_sg_id
}

output "rds_sg_id" {
  description = "RDS Security Group ID"
  value       = module.security_groups.rds_sg_id
}
