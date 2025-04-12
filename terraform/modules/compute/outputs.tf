output "vm_id" {
  description = "ID of the created VM instance"
  value       = google_compute_instance.pihole_vm.id
}

output "vm_name" {
  description = "Name of the VM instance"
  value       = google_compute_instance.pihole_vm.name
}

output "vm_zone" {
  description = "Zone of the VM instance"
  value       = google_compute_instance.pihole_vm.zone
}

output "internal_ip" {
  description = "Internal IP address of the VM instance"
  value       = google_compute_instance.pihole_vm.network_interface[0].network_ip
}

output "ssh_user" {
  description = "Username for SSH access"
  value       = var.ssh_username
}
