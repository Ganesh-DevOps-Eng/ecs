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
