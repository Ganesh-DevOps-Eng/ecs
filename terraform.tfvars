# terraform.tfvars

# General variables
project_name = "my-next-project"
env          = "dev"

# VPC module variables
vpc_cidr =  "10.0.0.0/16"
azs = ["us-east-1a"] 
app_port = 80
# Aurora module variables
db_name            = "mydb"
db_username        = "admin"
db_password        = "mysecretpassword"
instance_class     = "db.t3.medium"
instance_count     = 2
# ACM module variables
domain_name         = "example.com"
san_list            = ["www.example.com", "api.example.com"]
# IAM module variables
# ECS module variables
cpu                     = "256"
memory                  = "512"
container_definitions   = "container_definitions.json"
desired_count           = 1
subnet_ids              = ["subnet-12345678", "subnet-87654321"]
assign_public_ip        = false
security_group_id       = "sg-12345678"
enable_alb              = true
target_group_arn        = "arn:aws:elasticloadbalancing:region:account-id:targetgroup/my-target-group/1234567890abcdef"
container_name          = "my-container"
container_port          = 80
execution_role_arn      = "arn:aws:iam::account-id:role/my-execution-role"

# CI/CD variables
github_repo             = "my-repo"
github_owner            = "my-github-username"
github_oauth_token      = "my-github-token"
branch                  = "main"
buildspec_path          = "buildspec.yml"
codebuild_role_arn      = "arn:aws:iam::account-id:role/my-codebuild-role"
codedeploy_role_arn     = "arn:aws:iam::account-id:role/my-codedeploy-role"
artifact_bucket         = "my-artifact-bucket"
codedeploy_app_name     = "my-codedeploy-app"
codedeploy_group_name   = "my-codedeploy-group"
ecs_cluster_name        = "my-ecs-cluster"
ecs_service_name        = "my-ecs-service"
source_type       = "GITHUB"
artifacts_type    = "CODEPIPELINE"
source_location   = "https://github.com/my-org/my-repo.git"
compute_type      = "BUILD_GENERAL1_MEDIUM"
environment_image = "aws/codebuild/standard:5.0"
environment_type  = "LINUX_CONTAINER"
privileged_mode   = true

# ALB and CodePipeline variables
listener_arn            = "arn:aws:elasticloadbalancing:region:account-id:listener/app/my-load-balancer/1234567890abcdef/1234567890abcdef"
blue_target_group_name  = "my-blue-target-group"
green_target_group_name = "my-green-target-group"
codepipeline_role_arn   = "arn:aws:iam::account-id:role/my-codepipeline-role"

# Bastion host variables
bastion_ami_id          = "ami-12345678"
bastion_instance_type   = "t3.micro"
subnet_id               = "subnet-12345678"
bastion_key_name        = "my-key-pair"
security_group          = "sg-12345678"


