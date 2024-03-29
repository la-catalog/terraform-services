variable "rabbit_user" {
  type      = string
  sensitive = true
}

variable "rabbit_pass" {
  type      = string
  sensitive = true
}

resource "docker_image" "rabbit" {
  name = "rabbitmq:3.9.22-management"
}

resource "docker_container" "rabbit" {
  image = docker_image.rabbit.image_id
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
    "RABBITMQ_DEFAULT_USER=${var.rabbit_user}",
    "RABBITMQ_DEFAULT_PASS=${var.rabbit_pass}",
    "RABBITMQ_DEFAULT_VHOST=/",
  ]
}