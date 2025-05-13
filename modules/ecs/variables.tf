variable "project_name" { type = string }
variable "env" { type = string }
variable "cpu" { type = string }
variable "memory" { type = string }
variable "container_definitions" { type = string }
variable "desired_count" { type = number }
variable "subnet_ids" { type = list(string) }
variable "assign_public_ip" { type = bool }
variable "security_group_id" { type = string }
variable "enable_alb" { type = bool }
variable "target_group_arn" { type = string }
variable "container_name" { type = string }
variable "container_port" { type = number }

# New: IAM role to be passed from iam module
variable "execution_role_arn" { type = string }
