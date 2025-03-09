# Создаем NAT-инстанс

resource "yandex_compute_instance" "nat_instance" {
  name = "nat-instance"
  zone = var.default_zone
  platform_id = var.vm_platform

  resources {
    cores         = var.vms_resources.vm.cores
    memory        = var.vms_resources.vm.memory
    core_fraction = var.vms_resources.vm.core_fraction
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public_subnet.id
    nat       = true
    ip_address = "192.168.10.254"
  }

  boot_disk {
    initialize_params {
      image_id = "fd8prebgstl55l07plaj"
    }
  }

  scheduling_policy {
    preemptible = true
  }
}

# Создаем виртуалку с публичным IP

resource "yandex_compute_instance" "public_instance" {
  name = "public-vm"
  zone = var.default_zone
  platform_id = var.vm_platform
  count = var.count_vm

  resources {
    cores         = var.vms_resources.vm.cores
    memory        = var.vms_resources.vm.memory
    core_fraction = var.vms_resources.vm.core_fraction
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public_subnet.id
    nat       = true
    ip_address = "192.168.10.10"
  }

  boot_disk {
    initialize_params {
      image_id = "fd8pb31q5erinntlak02"
    }
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "red_usr:${local.ssh-keys}"
  }
}

# Создаем виртуалку в приватной подсети

resource "yandex_compute_instance" "private_instance" {
  name = "private-vm"
  zone = var.default_zone
  platform_id = var.vm_platform
  count = var.count_vm

  resources {
    cores         = var.vms_resources.vm.cores
    memory        = var.vms_resources.vm.memory
    core_fraction = var.vms_resources.vm.core_fraction
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private_subnet.id
    ip_address = "192.168.20.10"
  }

  boot_disk {
    initialize_params {
      image_id = "fd8pb31q5erinntlak02"
    }
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "red_usr:${local.ssh-keys}"
  }
}
