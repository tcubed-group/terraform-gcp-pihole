variable "vm_name" {
  description = "Name for the VM instance"
  type        = string
  default     = "pihole-server"
}

variable "vm_machine_type" {
  description = "Machine type for the VM instance"
  type        = string
  default     = "e2-micro"
}

variable "zone" {
  description = "Zone for the VM instance"
  type        = string
}

variable "network_tags" {
  description = "Network tags to assign to the VM instance"
  type        = list(string)
  default     = ["pihole", "http-server", "https-server"]
}

variable "vm_image" {
  description = "VM image to use"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "disk_size" {
  description = "Boot disk size in GB"
  type        = number
  default     = 20
}

variable "subnetwork_id" {
  description = "ID of the subnetwork to connect the VM to"
  type        = string
}

variable "static_ip" {
  description = "Static IP address to assign to the VM"
  type        = string
}

variable "ssh_username" {
  description = "Username for SSH access"
  type        = string
  default     = "pihole"
}

variable "ssh_pub_key_file" {
  description = "Path to the public SSH key file"
  type        = string
}

variable "labels" {
  description = "Labels to apply to the VM instance"
  type        = map(string)
  default = {
    environment = "production"
    service     = "pihole"
    managed-by  = "terraform"
  }
}
