resource "yandex_compute_disk" "additional_disks" {
  count = 3
  name     = "disk-name-${count.index + 1}"
  type     = "network-ssd"
  zone     = "ru-central1-a"
  size     = "1"

  labels = {
    environment = "test"
  }
}

#VM_STORAGE

resource "yandex_compute_instance" "storage" {
  name  = local.vm_storage
  platform_id = var.vm_platform
  
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
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
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.additional_disks
    content {
      disk_id = secondary_disk.value.id
    }
  }
}
