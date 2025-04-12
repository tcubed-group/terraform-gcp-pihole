# Network module for Pi-hole deployment

resource "google_compute_network" "pihole_network" {
  name                    = "${var.prefix}-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "pihole_subnet" {
  name          = "${var.prefix}-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.pihole_network.id
}

# Firewall rules
resource "google_compute_firewall" "pihole_ssh" {
  name    = "${var.prefix}-allow-ssh"
  network = google_compute_network.pihole_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.ssh_source_ranges
  target_tags   = ["pihole"]
}

resource "google_compute_firewall" "pihole_web" {
  name    = "${var.prefix}-allow-web"
  network = google_compute_network.pihole_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = var.web_source_ranges
  target_tags   = ["http-server", "https-server"]
}

resource "google_compute_firewall" "pihole_dns" {
  name    = "${var.prefix}-allow-dns"
  network = google_compute_network.pihole_network.name

  allow {
    protocol = "tcp"
    ports    = ["53"]
  }

  allow {
    protocol = "udp"
    ports    = ["53"]
  }

  source_ranges = var.dns_source_ranges
  target_tags   = ["pihole"]
}

# Static IP address
resource "google_compute_address" "pihole_ip" {
  name   = "${var.prefix}-static-ip"
  region = var.region
}
