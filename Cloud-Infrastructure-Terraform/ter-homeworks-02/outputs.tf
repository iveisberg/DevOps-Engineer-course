output "vm_instances_info" {
  value = {
    vm_web = {
      vm_instance_name = yandex_compute_instance.platform.name
      vm_external_ip   = yandex_compute_instance.platform.network_interface.0.nat_ip_address
      vm_fqdn          = yandex_compute_instance.platform.fqdn
    }
    vm_db = {
      vm_instance_name = yandex_compute_instance.db-platform.name
      vm_external_ip   = yandex_compute_instance.db-platform.network_interface.0.nat_ip_address
      vm_fqdn          = yandex_compute_instance.db-platform.fqdn
    }
  }
  description = "Information about VM instances: vm name, vm external IP, vm FQDN."
}

