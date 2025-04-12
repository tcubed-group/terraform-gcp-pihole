# Networking
resource "google_compute_network" "pihole_network" {
  name                    = "pihole-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "pihole_subnet" {
  name          = "pihole-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.gcp_region
  network       = google_compute_network.pihole_network.id
}

# Firewall rules
resource "google_compute_firewall" "pihole_ssh" {
  name    = "pihole-allow-ssh"
  network = google_compute_network.pihole_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"] # Consider restricting to your IP
  target_tags   = ["pihole"]
}

resource "google_compute_firewall" "pihole_web" {
  name    = "pihole-allow-web"
  network = google_compute_network.pihole_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"] # Consider restricting to your IP
  target_tags   = ["http-server", "https-server"]
}

resource "google_compute_firewall" "pihole_dns" {
  name    = "pihole-allow-dns"
  network = google_compute_network.pihole_network.name

  allow {
    protocol = "tcp"
    ports    = ["53"]
  }

  allow {
    protocol = "udp"
    ports    = ["53"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["pihole"]
}

# External IP
resource "google_compute_address" "pihole_ip" {
  name   = "pihole-static-ip"
  region = var.gcp_region
}

# VM instance
resource "google_compute_instance" "pihole_vm" {
  name         = var.vm_name
  machine_type = var.vm_machine_type
  zone         = var.gcp_zone
  tags         = var.network_tags

  boot_disk {
    initialize_params {
      image = var.vm_image
      size  = 20 # GB
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.pihole_subnet.id
    access_config {
      nat_ip = google_compute_address.pihole_ip.address
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_username}:${file(var.ssh_pub_key_file)}"
  }

  # This ensures the VM is only destroyed after the IP is removed
  depends_on = [google_compute_address.pihole_ip]

  # Add labels for better organization
  labels = {
    environment = "production"
    service     = "pihole"
    managed-by  = "terraform"
  }
}
