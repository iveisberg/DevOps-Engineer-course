locals {
  ssh-keys = file("~/.ssh/id_ed25519.pub")
}

locals {
    current_timestamp = timestamp()
    formatted_date = formatdate("DD-MM-YYYY", local.current_timestamp)
    bucket_name = "iveisberg-${local.formatted_date}"
}

locals {
  vm_name = "${var.company}-${var.dev}"
}
