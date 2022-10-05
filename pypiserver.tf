resource "docker_image" "pypiserver" {
  name = "pypiserver/pypiserver"
}

resource "docker_container" "pypiserver" {
  image = docker_image.pypiserver.latest
  name  = "pypiserver"

  ports {
    internal = 8080
    external = 8080
  }
}