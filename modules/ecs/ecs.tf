resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "demo_app_task_definition" {
  family                   = "vagrant-generator"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "${var.demo_app_task_definition}",
    "image": "${var.demo_app_image_url}",
    "cpu": 256,
    "memory": 512,
    "essential": true
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_default_vpc" "default_vpc" {
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = "us-east-1a"
}
resource "aws_default_subnet" "default_az2" {
  availability_zone = "us-east-1b"
}

resource "aws_security_group" "vagrant_generator_service_sg" {
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_service" "vagrant_generator_service" {
  name            = var.demo_app_service_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.demo_app_task_definition.arn
  launch_type     = "FARGATE"
  desired_count   = 1
  network_configuration {
    subnets          = ["${aws_default_subnet.default_az1.id}", "${aws_default_subnet.default_az2.id}"]
    security_groups  = ["${aws_security_group.vagrant_generator_service_sg.id}"]
    assign_public_ip = true
  }
  depends_on = [aws_security_group.vagrant_generator_service_sg, aws_ecs_task_definition.demo_app_task_definition]
}