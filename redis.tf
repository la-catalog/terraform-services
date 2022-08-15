resource "docker_image" "redis" {
  name = "redis"
}

resource "docker_container" "redis" {
  image = docker_image.redis.id
  name  = "redis"

  ports {
    internal = 6379
    external = 6379
  }
}