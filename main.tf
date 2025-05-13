module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  azs     = var.azs
  project_name = var.project_name
  env          = var.env
  app_port     = var.app_port
}



module "alb" {
  source            = "./modules/alb"
  project_name      = var.project_name
  env               = var.env
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.vpc.alb_sg_id
}

module "aurora" {
  source             = "./modules/aurora"
  project_name       = var.project_name
  env                = var.env
  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_ids = [module.vpc.aurora_sg_id]
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  instance_class     = var.instance_class
  instance_count     = var.instance_count
}

module "acm" {
  source       = "./modules/acm"
  project_name = var.project_name
  env          = var.env
  domain_name  = var.domain_name
  san_list     = var.san_list
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
  env          = var.env
}

module "ecs" {
  source               = "./modules/ecs"
  project_name         = var.project_name
  env                  = var.env
  container_definitions = file("${path.module}/container_definitions.json")
  cpu                  = var.cpu
  memory               = var.memory
  desired_count        = var.desired_count
  subnet_ids           = var.subnet_ids
  security_group_id    = var.security_group_id
  assign_public_ip     = var.assign_public_ip
  enable_alb           = var.enable_alb
  target_group_arn     = var.target_group_arn
  container_name       = var.container_name
  container_port       = var.container_port
  execution_role_arn   = var.execution_role_arn
}

module "route53" {
  source       = "./modules/route53"
  project_name = var.project_name
  env          = var.env
  domain_name  = var.domain_name

  records = [
    {
      name    = "app"
      type    = "A"
      ttl     = 300
      records = ["1.2.3.4"]
    },
    {
      name = "cdn"
      type = "A"
      alias = {
        name                   = "d123.cloudfront.net"
        zone_id                = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
      }
    }
  ]
}


module "s3" {
  source           = "./modules/s3"
  project_name     = var.project_name
  env              = var.env
  enable_versioning = true
}

module "cicd" {
  source                   = "./modules/cicd"
  project_name             = var.project_name
  env                      = var.env
  github_repo              = var.github_repo
  github_owner             = var.github_owner
  github_oauth_token       = var.github_oauth_token
  branch                   = var.branch
  buildspec_path           = var.buildspec_path
  codebuild_role_arn       = var.codebuild_role_arn
  codedeploy_role_arn      = var.codedeploy_role_arn
  artifact_bucket          = var.artifact_bucket
  codedeploy_app_name      = var.codedeploy_app_name
  codedeploy_group_name    = var.codedeploy_group_name
  ecs_cluster_name         = var.ecs_cluster_name
  ecs_service_name         = var.ecs_service_name
  listener_arn             = var.listener_arn
  blue_target_group_name   = var.blue_target_group_name
  green_target_group_name  = var.green_target_group_name
  codepipeline_role_arn    = var.codepipeline_role_arn
  source_type = var.source_type
  source_location = var.source_location
  artifacts_type = var.artifacts_type
  compute_type = var.compute_type
  environment_image = var.environment_image
  environment_type = var.environment_type
  privileged_mode = var.privileged_mode
}

module "bastion" {
  source          = "./modules/bastion"
  project_name    = var.project_name
  env             = var.env
  ami_id          = var.bastion_ami_id
  instance_type   = var.bastion_instance_type
  subnet_id       = module.vpc.public_subnet_ids[0]
  key_name        = var.bastion_key_name
  security_group  = module.sg.bastion_sg_id
}