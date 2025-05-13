variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

############## VPC Variables ##############
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "List of Availability Zones to use for resource creation"
  type        = list(string)
}

variable "app_port" {
  description = "Port for application traffic (e.g., 80 or 443)"
  type        = number
}

############### Aurora Variables ##############
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
}

variable "instance_count" {
  description = "Number of Aurora DB instances"
  type        = number
}

############### ACM Module Variables ##############
variable "domain_name" {
  type = string
}

variable "san_list" {
  type = list(string)
}

############### ECS Module Variables ##############
variable "cpu" {
  type = string
}

variable "memory" {
  type = string
}

variable "container_definitions" {
  type = string
}

variable "desired_count" {
  type = number
}

variable "subnet_ids" {
  type = list(string)
}

variable "assign_public_ip" {
  type = bool
}

variable "security_group_id" {
  type = string
}

variable "enable_alb" {
  type = bool
}

variable "target_group_arn" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_port" {
  type = number
}

variable "execution_role_arn" {
  type = string
}

############### Route53 Module Variables ##############
# Add Route53 variables here if needed

############### CICD Module Variables ##############
variable "github_repo" {
  type = string
}

variable "github_owner" {
  type = string
}

variable "github_oauth_token" {
  type = string
}

variable "branch" {
  type = string
}

variable "buildspec_path" {
  type = string
}

variable "codebuild_role_arn" {
  type = string
}

variable "codedeploy_role_arn" {
  type = string
}

variable "artifact_bucket" {
  type = string
}

variable "codedeploy_app_name" {
  type = string
}

variable "codedeploy_group_name" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

variable "listener_arn" {
  type = string
}

variable "blue_target_group_name" {
  type = string
}

variable "green_target_group_name" {
  type = string
}

variable "codepipeline_role_arn" {
  type = string
}

variable "source_type" {
  type = string
}

variable "source_location" {
  type = string
}

variable "artifacts_type" {
  type = string
}

variable "compute_type" {
  type = string
}

variable "environment_image" {
  type = string
}

variable "environment_type" {
  type = string
}

variable "privileged_mode" {
  description = "Whether to enable privileged mode for the build environment"
  type        = bool
}

############### Bastion Host Variables ##############
variable "bastion_ami_id" {
  description = "The AMI ID for the bastion host"
  type        = string
}

variable "bastion_instance_type" {
  description = "The instance type for the bastion host"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID where the bastion host will be deployed"
  type        = string
}

variable "bastion_key_name" {
  description = "The key pair name for SSH access"
  type        = string
}

variable "security_group" {
  description = "The security group for the bastion host"
  type        = string
}