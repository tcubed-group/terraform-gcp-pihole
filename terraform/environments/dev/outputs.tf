output "pihole_ip" {
  description = "The external IP address of the Pi-hole server"
  value       = module.network.static_ip
}

output "pihole_internal_ip" {
  description = "The internal IP address of the Pi-hole server"
  value       = module.compute.internal_ip
}

output "ssh_user" {
  description = "Username for SSH access"
  value       = module.compute.ssh_user
}

output "vm_name" {
  description = "Name of the VM instance"
  value       = module.compute.vm_name
}

output "vm_zone" {
  description = "Zone of the VM instance"
  value       = module.compute.vm_zone
}
