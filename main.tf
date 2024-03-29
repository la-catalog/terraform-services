terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.25.0"
    }

    linux = {
      source  = "TelkomIndonesia/linux"
      version = "~> 0.7.0"
    }
  }
}

variable "machine_ip" {
  type      = string
  sensitive = true
}

provider "docker" {
  host     = "ssh://${var.machine_ip}:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

provider "linux" {
  host = var.machine_ip
  user = var.machine_user
}