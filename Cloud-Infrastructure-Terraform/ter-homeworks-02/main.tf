#VM_WEB

resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_image_name
}

resource "yandex_compute_instance" "platform" {
  name        = local.vm_web
  platform_id = "standard-v2"
  resources {
    cores         = var.vms_resources.vm_web.cores
    memory        = var.vms_resources.vm_web.memory
    core_fraction = var.vms_resources.vm_web.core_fraction
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

  metadata = var.vms_metadata

  # metadata = {
  #   serial-port-enable = 1
  #   ssh-keys           = "ubuntu:${var.vms_ssh_public_root_key}"
  # }
}

#VM_DB

resource "yandex_vpc_network" "db_develop" {
  name = var.vm_db_vpc_name
}

resource "yandex_vpc_subnet" "db_develop" {
  name           = var.vm_db_vpc_name
  zone           = var.vm_db_default_zone
  network_id     = yandex_vpc_network.db_develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_compute_instance" "db-platform" {
  name        = local.vm_db
  platform_id = "standard-v2"
  resources {
    cores         = var.vms_resources.vm_db.cores
    memory        = var.vms_resources.vm_db.memory
    core_fraction = var.vms_resources.vm_db.core_fraction
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

  metadata = var.vms_metadata

  #   metadata = {
  #   serial-port-enable = 1
  #   ssh-keys           = "ubuntu:${var.vms_ssh_public_root_key}"
  # }
}
