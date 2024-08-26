resource "random_password" "root_password" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "password" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "docker_image" "mysql" {         
  name         = "mysql:8"
  keep_locally = false
}

resource "docker_container" "mysql" {
  image = docker_image.mysql.image_id                                                            
  name  = "mysql"
  #attach = "true"
  #user = "ubuntu:sudo"
  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.root_password.result}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${random_password.password.result}",
    "MYSQL_ROOT_HOST=%"
    ]
    
  ports {
    internal = 3306
    external = 33060
  }
}