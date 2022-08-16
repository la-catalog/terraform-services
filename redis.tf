resource "docker_image" "redis" {
  name = "redis:7.0.4"
}

resource "docker_container" "redis" {
  image = docker_image.redis.repo_digest
  name  = "redis"

  ports {
    internal = 6379
    external = 6379
  }
}