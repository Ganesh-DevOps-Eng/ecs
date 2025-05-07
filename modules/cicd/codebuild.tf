resource "aws_codebuild_project" "main_build" {
  name          = "${var.project_name}-${var.env}-build"
  service_role  = var.codebuild_role_arn
  build_timeout = 10

  source {
    type      = "GITHUB"
    location  = "https://github.com/${var.github_owner}/${var.github_repo}.git"
    buildspec = var.buildspec_path
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:6.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
  }

  tags = {
    Name = "${var.project_name}-${var.env}-build"
  }
}
