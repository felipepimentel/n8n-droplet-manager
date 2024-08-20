resource "digitalocean_loadbalancer" "n8n_lb" {
  name   = "n8n-loadbalancer"
  region = var.region

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"
    target_port    = 5678
    target_protocol = "http"
  }

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"
    target_port    = 5678
    target_protocol = "http"
    certificate_id = digitalocean_certificate.n8n_cert.id
  }

  healthcheck {
    protocol = "http"
    port     = 5678
    path     = "/"
  }

  droplet_ids = [digitalocean_droplet.n8n_droplet.id]
}

resource "digitalocean_certificate" "n8n_cert" {
  name    = "n8n-cert"
  type    = "lets_encrypt"
  domains = ["your-domain.com"]
}