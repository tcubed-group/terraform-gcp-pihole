output "network_id" {
  description = "ID of the created network"
  value       = google_compute_network.pihole_network.id
}

output "network_name" {
  description = "Name of the created network"
  value       = google_compute_network.pihole_network.name
}

output "subnet_id" {
  description = "ID of the created subnet"
  value       = google_compute_subnetwork.pihole_subnet.id
}

output "subnet_name" {
  description = "Name of the created subnet"
  value       = google_compute_subnetwork.pihole_subnet.name
}

output "static_ip" {
  description = "Static IP address for the Pi-hole server"
  value       = google_compute_address.pihole_ip.address
}
