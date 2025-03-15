# 4. Создание Application Load Balancer с использованием Instance group и проверкой состояния

resource "yandex_alb_backend_group" "backend_group" {
  depends_on = [yandex_compute_instance_group.ig]
  name = "lamp-backend-group"

  http_backend {
    name                   = "lamp-backend"
    weight                 = 1
    port                   = 80
    target_group_ids       = ["${yandex_compute_instance_group.ig.application_load_balancer[0].target_group_id}"]
    load_balancing_config {
      panic_threshold = 90
    }
    healthcheck {
      timeout          = "5s"
      interval         = "2s"
      healthy_threshold = 2
      unhealthy_threshold = 2
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_load_balancer" "alb" {
  depends_on = [yandex_compute_instance_group.ig]
  name = "lamp-alb"
  network_id  = yandex_vpc_network.my-vpc.id

  allocation_policy {
    location {
      zone_id   = var.default_zone
      subnet_id = yandex_vpc_subnet.public_subnet.id
    }
  }

  listener {
    name = "http-listener"
    endpoint {
      address {
        external_ipv4_address {}
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.router.id
      }
    }
  }

}

resource "yandex_alb_http_router" "router" {
  name = "lamp-http-router"
}

resource "yandex_alb_virtual_host" "virtual_host" {
  name           = "lamp-virtual-host"
  http_router_id = yandex_alb_http_router.router.id
  depends_on = [yandex_alb_backend_group.backend_group]

  route {
    name = "lamp-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.backend_group.id
      }
    }
  }
}
