terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
  # backend "s3" {
  #   bucket         = "ecs_demo"
  #   key            = "tf-infra/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "ecs_demo"
  #   encrypt        = true
  # }
}
# module "tf-state" {
#   source      = "./modules/tfstate"
#   bucket_name = local.tfstate_bucket_name
#   table_name  = local.tflocks_table_name
# }

# module "ecr-repo" {
#   source            = "./modules/ecr"
#   ecs_demo_ecr_repo = local.ecr_repo_name
# }

module "ecs-cluster" {
  source                   = "./modules/ecs"
  ecs_cluster_name         = local.ecs_cluster_name
  demo_app_image_url       = local.demo_app_image_url
  demo_app_task_definition = local.demo_app_task_definition
  demo_app_service_name    = local.demo_app_service_name
}