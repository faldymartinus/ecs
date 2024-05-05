variable "ecs_cluster_name" {
  description = "name of the ecs cluster"
  type        = string
}
variable "demo_app_task_definition" {
  description = "name of the demo app"
  type        = string
}

variable "demo_app_image_url" {
  description = "url of the container image"
  type        = string

}
variable "demo_app_service_name" {
  description = "name of the demo service"
  type        = string
}