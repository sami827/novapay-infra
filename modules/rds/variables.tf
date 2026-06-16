variable "private_subnet_ids" {
  description = "List of private subnet IDs fri the db group"
  type        = list(string)

}
variable "rds_sg_id" {
  description = "RDS Security Group"
  type        = string
}
variable "db_instance_class" {
  description = "DB instance class"
  type        = string
  default     = "db.t3.micro"
}
variable "db_name" {
  description = "Defined DB Name"
  type        = string
  default     = "novapay_records"
}
variable "db_username" {
  description = "DB username"
  type        = string
}
variable "db_password" {
  description = "DB password"
  type        = string
  sensitive   = true
}
variable "allocated_storage" {
  description = "Allocates storage"
  type        = number
  default     = 20
}
variable "project_name" {
  description = "Defined project name"
  type        = string
}
variable "environment" {
  description = "Environment"
  type        = string
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment for RDS"
  type        = bool
  default     = true
}
