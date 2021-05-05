variable "subnet_name" {
  type = string
}

variable "net_name" {
  type = string
}

resource "google_service_account" "instance_account" {
  account_id = "k8s-practice-account"
  display_name = "Kubernetes practice service account"
}

resource "google_compute_instance" "server" {
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-focal-v20210415"
    }
    auto_delete = false
  }

  machine_type = "n1-standard-2"
  name = "k8s-practice-server"
  zone = "us-central1-a"
  network_interface {
    network = var.net_name
    access_config {
    }
  }

  allow_stopping_for_update = true
  metadata = {
    ssh-keys = "user:${file("keys/id_gcp.pub")}"
  }
 
  service_account {
    email = google_service_account.instance_account.email
    scopes = ["cloud-platform"]
  }
}

//variable "public_ip" {
//  type = string
//}
