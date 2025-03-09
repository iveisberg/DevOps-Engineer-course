### naming cloud machines ###

variable "company" {
  type    = string
  default = "netology"
}

variable "dev" {
  type    = string
  default = "develop"
}

###cloud vars

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "public_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

# Создаем VPC

variable "vpc_name" {
  type        = string
  default     = "my-vpc"
  description = "VPC network"
}

# Создаем публичную подсеть

variable "vpc_name_public" {
  type        = string
  default     = "public_subnet"
  description = "VPC network&subnet name"
}

# Создаем приватную подсеть

variable "vpc_name_private" {
  type        = string
  default     = "private_subnet"
  description = "VPC network&subnet name"
}

variable "vm_platform" {
  type        = string
  default     = "standard-v2"
}

variable "count_vm" {
  type        = number
  default     = 1
}

variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    disk_volume   = number
  }))
  default = {
    vm = {
      cores = 2,
      memory = 2,
      disk_volume = 10,
      disk_type = "network-ssd",
      core_fraction = 5
    }
  }
  description = "Resource for VMs"
}
