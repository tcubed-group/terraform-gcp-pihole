# Compute module for Pi-hole deployment

# VM instance
resource "google_compute_instance" "pihole_vm" {
  name         = var.vm_name
  machine_type = var.vm_machine_type
  zone         = var.zone
  tags         = var.network_tags

  boot_disk {
    initialize_params {
      image = var.vm_image
      size  = var.disk_size
    }
  }

  network_interface {
    subnetwork = var.subnetwork_id
    access_config {
      nat_ip = var.static_ip
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_username}:${file(var.ssh_pub_key_file)}"
  }

  # Add labels for better organization
  labels = var.labels
}
