variable "meili_key" {
  type      = string
  sensitive = true
}

resource "docker_image" "meili" {
  name = "getmeili/meilisearch:v0.28.1"
}

resource "docker_container" "meili" {
  image = docker_image.meili.image_id
  name  = "meili"

  ports {
    internal = 7700
    external = 7700
  }

  env = [
    "MEILI_MASTER_KEY=${var.meili_key}",
  ]
}