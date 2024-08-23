terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
  required_version = "~>1.9.4" /*Многострочный комментарий.
 Требуемая версия terraform */
}
provider "docker" {}

#однострочный комментарий

resource "random_password" "random_string" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

# Pulls the image
resource "docker_image" "nginx" {         # ресурс должен иметь 2 значения тип и имя, добавил имя
  name         = "nginx:latest"
  keep_locally = true
}

# Create a container
resource "docker_container" "nginx" {     # имя не может начинаться с цифры, только с (_) или буквы
  image = docker_image.nginx.image_id                                                            
  name  = "example_${random_password.random_string.result}"  # имя ресурса с ошибкой "_FAKE" и result, а не resulT

  ports {
    internal = 80
    external = 9090
  }
}