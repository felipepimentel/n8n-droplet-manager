module "n8n_droplet" {
  source = "../../modules/droplet"

  droplet_name       = "n8n-droplet-dev"
  region             = "nyc3"
  size               = "s-1vcpu-1gb"
  image              = "ubuntu-22-04-x64"
  ssh_keys           = [var.ssh_fingerprint]
  monitoring_enabled = true
}
