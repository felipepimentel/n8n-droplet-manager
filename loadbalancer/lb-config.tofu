resource "digitalocean_loadbalancer" "n8n_lb" {
  name   = "n8n-loadbalancer"
  region = var.region
  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"
    target_port    = 5678
    target_protocol = "http"
  }
  healthcheck {
    protocol = "http"
    port     = 5678
    path     = "/"
  }
  droplet_ids = [digitalocean_droplet.n8n_droplet.*.id]
}
