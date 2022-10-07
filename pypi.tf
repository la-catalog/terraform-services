variable "pypi_user" {
  type      = string
  sensitive = true
}

variable "pypi_pass" {
  type      = string
  sensitive = true
}

resource "linux_script" "htpasswd" {
  lifecycle_commands {
    create = "echo ${var.machine_pass} | sudo -S apt install -y apache2-utils" # Install htpasswd
    read   = "apt-cache policy apache2-utils | grep 'Installed:' | grep -v '(none)' | awk '{ print $2 }' | xargs | tr -d '\n'"
    delete = "echo ${var.machine_pass} | sudo -S apt remove -y apache2-utils"
  }
}

resource "linux_script" "auth_dir" {
  lifecycle_commands {
    create = "mkdir -p /home/${var.machine_user}/pypi/auth"
    read   = "ls /home/${var.machine_user}/pypi | grep 'auth'"
    delete = "rm -rf /home/${var.machine_user}/pypi"
  }

  depends_on = [
    linux_script.htpasswd
  ]
}

resource "linux_script" "auth_file" {
  lifecycle_commands {
    create = "echo ${var.machine_pass} | sudo -S htpasswd -scb /home/${var.machine_user}/pypi/auth/htpasswd ${var.pypi_user} ${var.pypi_pass}"
    read   = "ls /home/${var.machine_user}/pypi/auth | grep 'htpasswd'"
    delete = "rm -f /home/${var.machine_user}/pypi/htpasswd"
  }

  depends_on = [
    linux_script.auth_dir
  ]
}

resource "docker_image" "pypi" {
  name = "pypiserver/pypiserver"
}

resource "docker_container" "pypi" {
  image = docker_image.pypi.latest
  name  = "pypi"
  command = [
    "-P",
    "/data/auth/htpasswd",
    "-a",
    "update,download,list",
    "/data/packages"
  ]

  ports {
    internal = 8080
    external = 8080
  }

  volumes {
    host_path      = "/home/${var.machine_user}/pypi/auth"
    container_path = "/data/auth"
  }

  depends_on = [
    linux_script.auth_file
  ]
}