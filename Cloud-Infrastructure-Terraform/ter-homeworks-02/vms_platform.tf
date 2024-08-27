###cloud vars
# variable "token" {
#   type        = string
#   description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
# }

variable "cloud_id" {
  type        = string
  default     = "b1g3h5uouq196iot3aqf"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1gue9v1tapk50i3uj7m"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vm_db_default_zone" {
  type        = string
  default     = "ru-central1-b"
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
  description = "VPC network & subnet name"
}

variable "vm_db_vpc_name" {
  type        = string
  default     = "db_develop"
  description = "VPC network & subnet name"
}

variable "vm_image_name" {
  type        = string
  default     = "ubuntu-2004-lts"
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
    },
    vm_db = {
      cores = 2,
      memory = 2,
      core_fraction = 20
    }
  }
  description = "Resource for VMs"
}


###ssh vars

variable "vms_metadata" {
  type = map(string)
  default = {
    "serial-port-enable" = "1"
    "ssh-keys"           = "ubuntu:ssh-ed25519 AAAAC3N*****"
  }
  description = "Metadata SSH-keys"
}

# variable "vms_ssh_public_root_key" {
#   type        = string
#   default     = "ssh-ed25519 AAAAC3N*****"
#   description = "ssh-keygen -t ed25519"
# }