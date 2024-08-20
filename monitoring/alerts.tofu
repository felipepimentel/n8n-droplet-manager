resource "digitalocean_monitor_alert" "cpu_alert" {
  alerts {
    email = ["your-email@example.com"]
  }
  window      = "5m"
  type        = "v1/insights/droplet/cpu"
  compare     = "GreaterThan"
  value       = 90
  enabled     = true
  entities    = [digitalocean_droplet.n8n_droplet.id]
  description = "CPU usage alert"
}

resource "digitalocean_monitor_alert" "memory_alert" {
  alerts {
    email = ["your-email@example.com"]
  }
  window      = "5m"
  type        = "v1/insights/droplet/memory_utilization_percent"
  compare     = "GreaterThan"
  value       = 90
  enabled     = true
  entities    = [digitalocean_droplet.n8n_droplet.id]
  description = "Memory usage alert"
}
