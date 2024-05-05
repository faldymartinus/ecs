locals {
  tfstate_bucket_name = "ecs-demo-faldy-trvlk-intrvw"
  tflocks_table_name  = "ecs-demo-faldy-trvlk-intrvw"
  ecr_repo_name       = "ecs-demo"

  ecs_cluster_name         = "demo_cluster"
  demo_app_image_url       = "faldymartinus/vagrant-generator:latest"
  demo_app_task_definition = "vagrant-generator-task-definition"
  demo_app_service_name    = "vagrant-generator-service"
  #   ecs_demo_cluster_name = "ecs-demo"
  # ecs_task_execution_role_name = "ecs-demo-ecs_task_execution_role"
  # application_load_balancer_name = "ecs-demo-alb"
  # target_group_name = "ecs-demo-alb-target"
  # container_port = 5000
  # demo_app_service_name = "vagrant-generator-service"
  # demo_app_task_name = "vagrant-generator-task"
}