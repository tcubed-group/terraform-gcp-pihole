variable "prefix" {
  description = "Prefix to use for resource names"
  type        = string
  default     = "pihole"
}

variable "region" {
  description = "GCP region for network resources"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR range for the subnet"
  type        = string
  default     = "10.0.0.0/24"
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
