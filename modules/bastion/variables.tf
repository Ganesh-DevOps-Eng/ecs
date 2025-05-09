variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "env" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the bastion host"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the bastion host"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "The subnet ID where the bastion host will be deployed"
  type        = string
}

variable "key_name" {
  description = "The key pair name for SSH access"
  type        = string
}

variable "security_group" {
  description = "The security group for the bastion host"
  type        = string
}