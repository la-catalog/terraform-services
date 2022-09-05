terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.20.0"
    }
  }
}

variable "MACHINE_IP" {
  type      = string
  sensitive = true
}

variable "MACHINE_USER" {
  type      = string
  sensitive = true
}

provider "docker" {
  host     = "ssh://${var.MACHINE_USER}@${var.MACHINE_IP}:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}