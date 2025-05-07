resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.project_name}-${var.env}-ecs-cluster"
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.project_name}-${var.env}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.execution_role_arn
  container_definitions    = var.container_definitions
}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.project_name}-${var.env}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = var.assign_public_ip
    security_groups  = [var.security_group_id]
  }

  dynamic "load_balancer" {
    for_each = var.enable_alb ? [1] : []
    content {
      target_group_arn = var.target_group_arn
      container_name   = var.container_name
      container_port   = var.container_port
    }
  }
}
