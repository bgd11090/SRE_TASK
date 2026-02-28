module "ecs" {
  source         = "./ecs_module"
  cluster_name   = var.cluster_name
  image          = var.image
  container_name = var.container_name
  cpu            = var.cpu
  memory         = var.memory
  port           = var.port
  app_env        = var.app_env
}