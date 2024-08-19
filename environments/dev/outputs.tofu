output "droplet_ip" {
  description = "The public IP address of the n8n Droplet"
  value       = module.n8n_droplet.droplet_ip
}

output "droplet_id" {
  description = "The ID of the n8n Droplet"
  value       = module.n8n_droplet.droplet_id
}
