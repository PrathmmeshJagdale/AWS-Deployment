########  BACKEND ############

resource "aws_ecs_task_definition" "flask" {
  family                   = "flask-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "flask"
      image = "${aws_ecr_repository.backend.repository_url}:latest"

      portMappings = [
        {
          containerPort = 5000
          protocol      = "tcp"
        }
      ]
    }
  ])
}



####### FRONTEND  #########

resource "aws_ecs_task_definition" "express" {
  family                   = "express-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "express"
      image = "${aws_ecr_repository.frontend.repository_url}:latest"

       portMappings = [
      {
        containerPort = 3000
        hostPort      = 3000
      }
    ],

    environment = [
      {
        name  = "BACKEND_URL"
        value = "http://${aws_lb.main.dns_name}/api/message"
      }
    ]
    }
  ])
}


