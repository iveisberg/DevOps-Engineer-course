# 3. Создание сетевого балансировщика

resource "yandex_lb_target_group" "target_group" {
  name      = "lamp-target-group"
  folder_id = var.folder_id
  depends_on = [yandex_compute_instance_group.ig]

  dynamic "target" {
    for_each = yandex_compute_instance_group.ig.instances
    content {
      address  = target.value.network_interface[0].ip_address
      subnet_id = yandex_vpc_subnet.public_subnet.id
    }
  }
}

resource "yandex_lb_network_load_balancer" "lb" {
  depends_on = [yandex_compute_instance_group.ig]
  name = "lamp-network-lb"
  deletion_protection = false

  listener {
    name    = "http-listener"
    port    = 80
    protocol = "tcp"
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.target_group.id

    healthcheck {
      name = "http-healthcheck"
      interval = 5
      timeout = 2
      unhealthy_threshold = 3
      healthy_threshold = 3
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
