variable "vpc_id" {
  description = "VPC ID to attach security groups to"
  type        = string
}

variable "project_name" {
  description = "Project name for naming and tagging"
  type        = string
}

variable "environment" {
  description = "Environment name — dev, staging, prod"
  type        = string
}
