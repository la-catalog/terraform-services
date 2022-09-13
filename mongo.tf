variable "mongo_user" {
  type      = string
  sensitive = true
}

variable "mongo_pass" {
  type      = string
  sensitive = true
}

resource "docker_image" "mongo" {
  name = "mongo:5.0.10"
}

resource "docker_container" "mongo" {
  image = docker_image.mongo.repo_digest
  name  = "mongo"

  ports {
    internal = 27017
    external = 27017
  }

  env = [
    "MONGO_INITDB_ROOT_USERNAME=${var.mongo_user}",
    "MONGO_INITDB_ROOT_PASSWORD=${var.mongo_pass}",
  ]
}