# Создаем VPC

resource "yandex_vpc_network" "my-vpc" {
  name = var.vpc_name
}

# Создаем публичную подсеть

resource "yandex_vpc_subnet" "public_subnet" {
  name           = var.vpc_name_public
  zone           = var.default_zone
  network_id     = yandex_vpc_network.my-vpc.id
  v4_cidr_blocks = var.public_cidr
}

# Создаем приватную подсеть

resource "yandex_vpc_subnet" "private_subnet" {
  name           = var.vpc_name_private
  zone           = var.default_zone
  network_id     = yandex_vpc_network.my-vpc.id
  route_table_id = yandex_vpc_route_table.private_route_table.id
  v4_cidr_blocks = var.private_cidr
}

# Создание маршрутов

resource "yandex_vpc_route_table" "private_route_table" {
  name = "private-route"
  network_id = yandex_vpc_network.my-vpc.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.nat_instance.network_interface[0].ip_address
  }
}
