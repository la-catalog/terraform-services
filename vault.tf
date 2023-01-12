variable "vault_token" {
  type      = string
  sensitive = true
}

resource "docker_image" "vault" {
  name = "vault:1.11.3"
}

resource "docker_container" "vault" {
  image = docker_image.vault.image_id
  name  = "vault"

  ports {
    internal = 8200
    external = 8200
  }

  env = [
    "VAULT_DEV_ROOT_TOKEN_ID=${var.vault_token}",
    "VAULT_DEV_LISTEN_ADDRESS=0.0.0.0:8200",
  ]
}