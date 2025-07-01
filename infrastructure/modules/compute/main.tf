resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "server" {
  family = "twenty-server"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = var.execution_role_arn
  task_role_arn = var.task_role_arn
  cpu = var.server_cpu
  memory = var.server_memory

  container_definitions = jsonencode([{
    name = "twenty-server"
    image = var.server_image
    essential = true
    environment = [
      { name = "SERVER_URL", value = var.server_url },
      { name = "PGHOST", value = var.db_endpoint },
      { name = "PGDATABASE", value = var.db_name },
      { name = "PGUSER", value = var.db_username },
      { name = "S3_BUCKET", value = var.s3_bucket_name },
    ]
    secrets = [
      { name = "APP_SECRET", valueFrom = var.app_secret_arn },
      { name = "PGPASSWORD_SUPERUSER", valueFrom = var.pgpassword_secret_arn }
    ]
    portMappings = [{ 
      containerPort = var.server_container_port
      hostPort      = var.server_container_port
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-region"        = var.region
        "awslogs-stream-prefix" = "ecs-server"
      }
    }
  }])
}

resource "aws_ecs_task_definition" "worker" {
  family = "twenty-worker"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = var.execution_role_arn
  task_role_arn = var.task_role_arn
  cpu = var.worker_cpu
  memory = var.worker_memory

  container_definitions = jsonencode([{
    name = "twenty-worker"
    image = var.worker_image
    essential = true
    environment = [
      { name = "PGHOST", value = var.db_endpoint },
      { name = "PGDATABASE", value = var.db_name },
      { name = "PGUSER", value = var.db_username },
      { name = "S3_BUCKET", value = var.s3_bucket_name },
    ]
    secrets = [
      { name = "APP_SECRET", valueFrom = var.app_secret_arn },
      { name = "PGPASSWORD_SUPERUSER", valueFrom = var.pgpassword_secret_arn }
    ]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-region" = var.region
        "awslogs-stream-prefix" = "ecs-worker"
      }
    }
  }])
}

resource "aws_ecs_service" "server" {
  name = "twenty-server"
  cluster = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.server.arn
  desired_count = var.server_desired_count
  launch_type = "FARGATE"

  network_configuration {
    subnets = var.private_subnets
    security_groups  = [var.ecs_security_group_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name = "twenty-server"
    container_port = var.server_container_port
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }
}

resource "aws_ecs_service" "worker" {
  name = "twenty-worker"
  cluster = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.worker.arn
  desired_count = var.worker_desired_count
  launch_type = "FARGATE"

  network_configuration {
    subnets = var.private_subnets
    security_groups = [var.ecs_security_group_id]
    assign_public_ip = false
  }
}

resource "aws_appautoscaling_target" "server_scale" {
  service_namespace = "ecs"
  resource_id = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.server.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity = var.server_min_capacity
  max_capacity = var.server_max_capacity
}

resource "aws_appautoscaling_policy" "server_scale_cpu" {
  name = "server-scale-cpu"
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.server_scale.resource_id
  scalable_dimension = aws_appautoscaling_target.server_scale.scalable_dimension
  service_namespace = aws_appautoscaling_target.server_scale.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 70
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}
