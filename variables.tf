variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "project_name" {}
variable "env" {}
variable "github_repo" {}
variable "github_owner" {}
variable "github_oauth_token" {}
variable "branch" {
  default = "main"
}
variable "buildspec_path" {
  default = "buildspec.yml"
}
variable "codebuild_role_arn" {}
variable "codedeploy_role_arn" {}
variable "artifact_bucket" {}
variable "codedeploy_app_name" {}
variable "codedeploy_group_name" {}
variable "ecs_cluster_name" {}
variable "ecs_service_name" {}

variable "listener_arn" {}
variable "blue_target_group_name" {}
variable "green_target_group_name" {}
variable "codepipeline_role_arn" {}


variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "env" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}

variable "bastion_ami_id" {
  description = "The AMI ID for the bastion host"
  type        = string
}

variable "bastion_instance_type" {
  description = "The instance type for the bastion host"
  type        = string
  default     = "t3.micro"
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