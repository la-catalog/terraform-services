resource "docker_image" "redis" {
  name = "redis"
}

resource "docker_container" "redis" {
  image = docker_image.redis.latest
  name  = "redis"

  ports {
    internal = 6379
    external = 6379
  }
}