variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "env" {
  description = "Environment (dev/stage/prod)"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for Aurora"
  type        = list(string)
}

variable "db_name" {
  description = "Aurora DB database name"
  type        = string
}

variable "db_username" {
  description = "Aurora DB master username"
  type        = string
}

variable "db_password" {
  description = "Aurora DB master password"
  type        = string
  sensitive   = true
}

variable "instance_class" {
  description = "Instance class for Aurora instances"
  type        = string
  default     = "db.t3.medium"
}

variable "instance_count" {
  description = "Number of Aurora DB instances"
  type        = number
  default     = 2
}