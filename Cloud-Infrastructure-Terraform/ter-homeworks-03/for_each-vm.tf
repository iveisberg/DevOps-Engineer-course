#VM_DB

resource "yandex_compute_instance" "db" {
    for_each = {
        for env in var.vms_db_resources : env.vm_name => env
        }
    name  = "${local.vm_db}-${each.value.vm_name}"
    platform_id = var.vm_platform

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh-keys}"
  }
}