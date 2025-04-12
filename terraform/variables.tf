variable "gcp_project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "gcp_region" {
  description = "The GCP region to deploy resources"
  type        = string
  default     = "us-central1"
}

variable "gcp_zone" {
  description = "The GCP zone to deploy resources"
  type        = string
  default     = "us-central1-a"
}

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

variable "vm_image" {
  description = "VM image to use"
  type        = string
  default     = "debian-cloud/debian-11"
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

variable "network_tags" {
  description = "Network tags to apply to the VM instance"
  type        = list(string)
  default     = ["pihole", "http-server", "https-server"]
}
