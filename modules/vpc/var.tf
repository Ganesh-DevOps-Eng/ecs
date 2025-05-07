variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "env" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of availability zones to use"
  type        = number
  default     = 2
}

variable "app_port" {
  description = "Port for application traffic (e.g., 80 or 443)"
  type        = number
  default     = 80
}
