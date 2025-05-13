resource "aws_codebuild_project" "main_build" {
  name          = "${var.project_name}-${var.env}-build"
  service_role  = var.codebuild_role_arn
  build_timeout = 10

  source {
    type      = var.source_type
    location  = var.source_location
    buildspec = var.buildspec_path
  }

  artifacts {
    type = var.artifacts_type
  }

  environment {
    compute_type    = var.compute_type
    image           = var.environment_image
    type            = var.environment_type
    privileged_mode = var.privileged_mode
  }

  tags = {
    Name = "${var.project_name}-${var.env}-build"
  }
}