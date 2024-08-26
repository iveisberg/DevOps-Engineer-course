terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.9.4"
}

provider "yandex" {
  #token                   = "var.token"
  service_account_key_file = "/home/dbn_usr/key.json"
  cloud_id                 = "b1g3h5uouq196iot3aqf"
  folder_id                = "b1gue9v1tapk50i3uj7m"
  zone                     = "ru-central1-a"
  #shared_credentials_file  = "path_to_shared_credentials_file"
  profile                  = "sa-terraform"
}

provider "docker" {
  host     = "ssh://ubuntu@84.201.175.110:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}
