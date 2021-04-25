variable "subnetwork" {
  type = string
}

resource "google_compute_instance" "server" {
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-focal-v20210415"
    }
    auto_delete = false
  }

  machine_type = "e2-standard-2"
  name = "k8s-practice-server"
  zone = "us-west1-a"
  network_interface {
    subnetwork = var.subnetwork
  }
}
