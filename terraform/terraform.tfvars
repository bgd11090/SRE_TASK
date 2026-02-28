cluster_name   = "sre-task-cluster-name"
image          = "ghcr.io/bgd11090/sre-task:latest"
container_name = "sre-task-app"
cpu            = 256
memory         = 512
port           = 3000
app_env = {
	ENV = "prod"
}