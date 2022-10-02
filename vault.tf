variable "vault_token" {
  type      = string
  sensitive = true
}

variable "vault_ip" {
  default = "0.0.0.0"
  type    = string
}

variable "vault_port" {
  default = 8200
  type    = number
}

resource "docker_image" "vault" {
  name = "vault:1.11.3"
}

resource "docker_container" "vault" {
  image = docker_image.vault.repo_digest
  name  = "vault"

  ports {
    internal = var.vault_port
    external = var.vault_port
  }

  env = [
    "VAULT_DEV_ROOT_TOKEN_ID=${var.vault_token}",
    "VAULT_DEV_LISTEN_ADDRESS=${var.vault_ip}:${var.vault_port}",
  ]
}