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