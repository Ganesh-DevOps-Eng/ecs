module "vpc" {
  source       = "./vpc"
  vpc_cidr     = "10.0.0.0/16"
  az_count     = 2
  project_name = "ecs"
  env          = "dev"
  app_port     = 80
}



module "alb" {
  source            = "./alb"
  project_name      = var.project_name
  env               = var.env
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.sg.alb_sg_id
}

module "aurora" {
  source             = "./aurora"
  project_name       = "ecs"
  env                = "dev"
  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_ids = [module.vpc.default_sg_id]
  db_name            = "mydb"
  db_username        = "admin"
  db_password        = "securepassword123"
  instance_class     = "db.t3.medium"
  instance_count     = 2
}

module "acm" {
  source       = "./modules/acm"
  project_name = var.project_name
  env          = var.env
  domain_name  = "example.com"
  san_list     = ["www.example.com"]
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
  env          = var.env
}

module "ecs" {
  source               = "./ecs"
  project_name         = "myapp"
  env                  = "dev"
  container_definitions = jsonencode([
    {
      name      = "myapp"
      image     = "nginx:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
  cpu               = "256"
  memory            = "512"
  desired_count     = 1
  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = aws_security_group.ecs_sg.id
  assign_public_ip  = false
  enable_alb        = true
  target_group_arn  = aws_lb_target_group.app_tg.arn
  container_name    = "myapp"
  container_port    = 80
}

module "route53" {
  source       = "./modules/route53"
  project_name = "ecs"
  env          = "dev"
  domain_name  = "example.com"

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
  project_name     = "ecs"
  env              = "dev"
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