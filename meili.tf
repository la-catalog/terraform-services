variable "meili_pass" {
  type      = string
  sensitive = true
}

resource "docker_image" "meili" {
  name = "getmeili/meilisearch"
}

resource "docker_container" "meili" {
  image = docker_image.meili.latest
  name  = "meili"

  ports {
    internal = 7700
    external = 7700
  }

  env = [
    "MEILI_MASTER_KEY=${var.meili_pass}",
  ]
}