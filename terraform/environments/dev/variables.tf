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

variable "resource_prefix" {
  description = "Prefix to use for resource names"
  type        = string
  default     = "pihole-dev"
}

variable "subnet_cidr" {
  description = "CIDR range for the subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "vm_machine_type" {
  description = "Machine type for the VM instance"
  type        = string
  default     = "e2-micro"
}

variable "network_tags" {
  description = "Network tags to assign to the VM instance"
  type        = list(string)
  default     = ["pihole", "http-server", "https-server"]
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

variable "ssh_source_ranges" {
  description = "Source IP ranges for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Consider restricting this to your IP range
}

variable "web_source_ranges" {
  description = "Source IP ranges for web access (HTTP/HTTPS)"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Consider restricting this to your IP range
}

variable "dns_source_ranges" {
  description = "Source IP ranges for DNS access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
