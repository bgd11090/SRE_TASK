output "cluster_name" {
  value = aws_ecs_cluster.ecs.name
}

output "service_name" {
  value = aws_ecs_service.app.name
}
