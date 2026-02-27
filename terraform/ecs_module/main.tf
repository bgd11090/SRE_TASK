resource "aws_ecs_cluster" "ecs" {
  name = var.cluster_name

  tags = {
    SRE_TASK = "Djordje Petrovic"
  }
}