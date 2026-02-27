module "ecs" {
  source       = "./ecs_module"
  cluster_name = var.cluster_name
}