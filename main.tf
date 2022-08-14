terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.20.0"
    }

    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

###### Notebook access ######

variable "machine_ip" {
  type      = string
  sensitive = true
}

variable "machine_user" {
  type      = string
  sensitive = true
}

provider "docker" {
  host     = "ssh://${var.machine_user}@${var.machine_ip}:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

###### Github access ######

variable "github_token" {
  type      = string
  sensitive = true
}

provider "github" {
  token         = var.github_token
  owner         = "la-catalog"
  read_delay_ms = 1000
}