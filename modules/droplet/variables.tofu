variable "droplet_name" {
  type = string
}

variable "region" {
  type = string
}

variable "size" {
  type = string
}

variable "image" {
  type = string
}

variable "ssh_keys" {
  type = list(string)
}

variable "monitoring_enabled" {
  type    = bool
  default = true
}
