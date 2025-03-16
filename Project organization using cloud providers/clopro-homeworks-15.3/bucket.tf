# 1. Создание бакета в Object Storage

resource "yandex_storage_bucket" "bucket" {
  bucket = local.bucket_name
  # default_storage_class = "COLD"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  access_key = var.bucket_access_key
  secret_key = var.bucket_secret_key
  acl    = "public-read"    # Делаем бакет доступным из интернета
  max_size = 1073741824

  anonymous_access_flags {
    read = true
    list = false
  }
}

resource "yandex_kms_symmetric_key" "key" {
  name              = "encryption-key"
  description       = "Key for encrypting bucket contents"
  default_algorithm = "AES_256"
  rotation_period   = "8760h" // equal to 1 year
  }

# Загрузка файла в бакет

resource "yandex_storage_object" "image" {
  bucket = yandex_storage_bucket.bucket.bucket
  key    = "image.jpg"
  source = "~/image.jpg"
  content_type = "image/jpg"
  acl    = "public-read"
}

# 2. Создание Instance Group с шаблоном LAMP

resource "yandex_compute_instance_group" "ig" {
  name                = "lamp-instance-group"
  folder_id           = var.folder_id
  service_account_id  = var.sa_id
  deletion_protection = false

  instance_template {
    platform_id = var.vm_platform
    resources {
      cores         = var.vms_resources.vm.cores
      memory        = var.vms_resources.vm.memory
      core_fraction = var.vms_resources.vm.core_fraction
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd8h6prkngc2h14ij2i0" #fd8jeo11bntuv900j8jd
        size     = 4
      }
    }
    network_interface {
      network_id = yandex_vpc_network.my-vpc.id
      subnet_ids = ["${yandex_vpc_subnet.public_subnet.id}"]
      nat        = false
    }
    metadata = {
      ssh-keys = "ubuntu:${local.ssh-keys}"
      serial-port-enable = "1"
      user_data = <<-EOF
        #cloud-config
        runcmd:
          - sudo chmod 755 /var/www/html/index.html
          - sudo chown ubuntu:ubuntu /var/www/html/index.html
          - sudo echo "<html><body><h1>Link to the image</h1><img src='https://storage.yandexcloud.net/${yandex_storage_bucket.bucket.bucket}/${yandex_storage_object.image.key}' /></body></html>" > /var/www/html/index.html
          - sudo systemctl reload apache2.service
        EOF
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 3
    max_deleting    = 2
  }

  health_check {
    interval  = 10
    timeout   = 5
    tcp_options {
      port = 80
    }
  }

  application_load_balancer {
    target_group_name = "lamp-target-group" 
  }
}
