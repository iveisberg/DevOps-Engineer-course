###naming cloud machines

variable "company" {
  type    = string
  default = "netology"
}

variable "dev" {
  type    = string
  default = "develop"
}

variable "platform-web" {
  type        = string
  default     = "platform-web"
}

variable "platform-db" {
  type        = string
  default     = "platform-db"
}

variable "platform-storage" {
  type        = string
  default     = "platform-storage"
}


###cloud vars

# variable "token" {
#   type        = string
#   description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
# }

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

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vm_platform" {
  type        = string
  default     = "standard-v2"
}

variable "vm_image_name" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "count_vm" {
  type        = number
  default     = 2
}

variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
    vm_web = {
      cores = 2,
      memory = 1,
      core_fraction = 5
    }
  }
  description = "Resource for VMs"
}

variable "vms_db_resources" {
  type = list(object({
    vm_name       = string,
    cpu           = number,
    ram           = number,
    disk_volume   = number,
    core_fraction = number
    }))
    default = [
    {
      vm_name = "main",
      cpu = 2,
      ram = 2,
      disk_volume = 10,
      core_fraction = 5
      },
      {
      vm_name = "replica",
      cpu = 2,
      ram = 1,
      disk_volume = 10,
      core_fraction = 5
      }
    ]
  description = "Resource for DB VMs"
}
