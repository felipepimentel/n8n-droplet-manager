resource "digitalocean_droplet" "n8n_droplet" {
  name   = var.droplet_name
  region = var.region
  size   = var.size
  image  = var.image

  ssh_keys = var.ssh_keys

  monitoring = var.monitoring_enabled

  lifecycle {
    prevent_destroy = false
  }
}

output "droplet_ip" {
  value = digitalocean_droplet.n8n_droplet.ipv4_address
}

output "droplet_id" {
  value = digitalocean_droplet.n8n_droplet.id
}
