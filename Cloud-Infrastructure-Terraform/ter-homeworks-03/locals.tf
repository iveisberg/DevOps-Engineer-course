locals {
  vm_web = "${var.company}-${var.dev}-${var.platform-web}"
}

locals {
  vm_db = "${var.company}-${var.dev}-${var.platform-db}"
}

locals {
  vm_storage = "${var.company}-${var.dev}-${var.platform-storage}"
}

locals {
  ssh-keys = file("~/.ssh/id_ed25519.pub")
}
