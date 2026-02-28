resource "aws_ecs_cluster" "ecs" {
  name = var.cluster_name

  tags = {
    SRE_TASK = "Djordje Petrovic"
  }
}

resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/ecs/${var.container_name}"
  retention_in_days = 7
  tags = {
    SRE_TASK = "Djordje Petrovic"
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = var.container_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  container_definitions    = jsonencode([
    {
      name      = var.container_name
      image     = var.image
      essential = true
      portMappings = [
        {
          containerPort = var.port
          hostPort      = var.port
        }
      ]
      environment = [{ name = "ENV", value = "prod" }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.app_logs.name
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
  tags = {
    SRE_TASK = "Djordje Petrovic"
  }
}