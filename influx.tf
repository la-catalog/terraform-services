variable "influx_user" {
  type      = string
  sensitive = true
}

variable "influx_pass" {
  type      = string
  sensitive = true
}

resource "docker_image" "influx" {
  name = "influxdb"
}

resource "docker_container" "influx" {
  image = docker_image.influx.id
  name  = "influx"

  ports {
    internal = 8086
    external = 8086
  }

  env = [
    "DOCKER_INFLUXDB_INIT_USERNAME=${var.influx_user}",
    "DOCKER_INFLUXDB_INIT_PASSWORD=${var.influx_pass}",
    "DOCKER_INFLUXDB_INIT_ORG=la-catalog",
    "DOCKER_INFLUXDB_INIT_BUCKET=la-catalog",
  ]
}