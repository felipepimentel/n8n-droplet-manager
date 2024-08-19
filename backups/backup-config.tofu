resource "digitalocean_droplet_snapshot" "n8n_backup" {
  droplet_id = digitalocean_droplet.n8n_droplet.id
  name       = "n8n-daily-backup"
  regions    = ["nyc3"]
  lifetime   = 7 # Keep snapshot for 7 days
}
