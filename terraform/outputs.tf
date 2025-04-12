output "pihole_ip" {
  description = "The external IP address of the Pi-hole server"
  value       = google_compute_address.pihole_ip.address
}

output "pihole_internal_ip" {
  description = "The internal IP address of the Pi-hole server"
  value       = google_compute_instance.pihole_vm.network_interface[0].network_ip
}

output "ssh_user" {
  description = "Username for SSH access"
  value       = var.ssh_username
}

output "vm_name" {
  description = "Name of the VM instance"
  value       = google_compute_instance.pihole_vm.name
}

output "vm_zone" {
  description = "Zone of the VM instance"
  value       = google_compute_instance.pihole_vm.zone
}
