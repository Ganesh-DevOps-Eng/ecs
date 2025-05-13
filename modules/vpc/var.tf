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

variable "azs" {
  description = "List of Availability Zones to use for resource creation"
  type        = list(string)
  default     = ["us-east-1a"] # Specify the default AZ(s) here
}

variable "app_port" {
  description = "Port for application traffic (e.g., 80 or 443)"
  type        = number
  default     = 80
}
