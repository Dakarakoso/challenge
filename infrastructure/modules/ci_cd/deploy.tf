resource "aws_codedeploy_app" "ecs" {
  name             = "${var.pipeline_name}-cd-app"
  compute_platform = "ECS"
}

resource "aws_codedeploy_deployment_group" "ecs" {
  app_name              = aws_codedeploy_app.ecs.name
  deployment_group_name = "${var.pipeline_name}-dg"
  service_role_arn      = aws_iam_role.codepipeline.arn

  deployment_style {
    deployment_type   = "BLUE_GREEN"
    deployment_option = "WITH_TRAFFIC_CONTROL"
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout    = "CONTINUE_DEPLOYMENT"
      wait_time_in_minutes = 0
    }
    green_fleet_provisioning_option {
      action = "DISCOVER_EXISTING"
    }
    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  load_balancer_info {
    target_group_pair_info {
      target_group {
        name = var.blue_target_group_name
      }
      target_group {
        name = var.green_target_group_name
      }
      prod_traffic_route {
        listener_arns = [var.alb_listener_arn]
      }
      test_traffic_route {
        listener_arns = [var.alb_listener_arn]
      }
    }
  }

  ecs_service {
    cluster_name = var.ecs_cluster_name
    service_name = var.ecs_service_name
  }

  alarm_configuration {
    enabled                   = true
    ignore_poll_alarm_failure = false
    alarms = [
      var.alb_alarm_name,
      var.ecs_cpu_alarm_name,
      var.ecs_memory_alarm_name,
      var.rds_cpu_alarm_name,
    ]
  }


  auto_rollback_configuration {
    enabled = true
    events = ["DEPLOYMENT_FAILURE",
      "DEPLOYMENT_STOP_ON_ALARM",
    ]
  }
}
