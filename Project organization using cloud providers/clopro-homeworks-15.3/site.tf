# Создание бакета в Object Storage

resource "yandex_storage_bucket" "net-iveisberg" {
  bucket = "net-iveisberg"
  access_key = var.bucket_access_key
  secret_key = var.bucket_secret_key
  acl    = "public-read"    # Делаем бакет доступным из интернета
  max_size = 1073741824

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  https {
    certificate_id = "fpq1ncqn7fgmis3eldd2"
  }
}

# Загрузка файла в бакет

resource "yandex_storage_object" "index_document" {
  bucket = yandex_storage_bucket.net-iveisberg.bucket
  key        = "index.html"
  source     = "index.html"
  acl    = "public-read"
  depends_on = [yandex_storage_bucket.net-iveisberg]
}
