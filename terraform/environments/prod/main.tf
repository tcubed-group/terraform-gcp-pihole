provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0"

  # For production, you should use remote state
  # backend "gcs" {
  #   bucket = "your-terraform-state-bucket"
  #   prefix = "pihole/prod"
  # }
}

module "network" {
  source = "../../modules/network"

  prefix         = var.resource_prefix
  region         = var.gcp_region
  subnet_cidr    = var.subnet_cidr

  # In production, restrict access to specific IP ranges
  ssh_source_ranges = var.ssh_source_ranges
  web_source_ranges = var.web_source_ranges
  dns_source_ranges = var.dns_source_ranges
}

module "compute" {
  source = "../../modules/compute"

  vm_name          = "${var.resource_prefix}-vm"
  vm_machine_type  = var.vm_machine_type
  zone             = var.gcp_zone
  network_tags     = var.network_tags
  subnetwork_id    = module.network.subnet_id
  static_ip        = module.network.static_ip
  ssh_username     = var.ssh_username
  ssh_pub_key_file = var.ssh_pub_key_file

  labels = {
    environment = "production"
    service     = "pihole"
    managed-by  = "terraform"
    project     = var.resource_prefix
  }

  # Ensure the network is created before the VM
  depends_on = [
    module.network
  ]
}
