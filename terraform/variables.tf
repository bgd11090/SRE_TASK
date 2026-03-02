variable "cluster_name" {
  type        = string
}

variable "image" {
  type = string
}

variable "container_name" {
  type = string
}

variable "cpu" {
  type = number
}

variable "memory" {
  type = number
}

variable "app_env" {
  type = map(string)
}

variable "port" {
  type = number
}

variable "service_name" {
  type = string
}

variable "desired_count" {
  type = number
}