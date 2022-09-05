variable "RABBIT_USER" {
  type      = string
  sensitive = true
}

variable "RABBIT_PASS" {
  type      = string
  sensitive = true
}

resource "docker_image" "rabbit" {
  name = "rabbitmq:3.9.22-management"
}

resource "docker_container" "rabbit" {
  image = docker_image.rabbit.repo_digest
  name  = "rabbit"

  ports {
    internal = 5672
    external = 5672
  }

  ports {
    internal = 15672
    external = 15672
  }

  env = [
    "RABBITMQ_DEFAULT_USER=${var.RABBIT_USER}",
    "RABBITMQ_DEFAULT_PASS=${var.RABBIT_PASS}",
    "RABBITMQ_DEFAULT_VHOST=/",
  ]
}