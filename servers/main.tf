variable "image_name" {
  type = string
}

variable "image_family" {
  type = string
}

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
      image = join("/", [var.image_family, var.image_name])
    }
    auto_delete = true
  }

  //tags = ["http-server","https-server"]
  machine_type = "e2-standard-2"
  name = "k8s-server"
  zone = "us-west1-a"
  network_interface {
    subnetwork = var.subnet_name
    //network = var.net_name
    access_config {
    }
  }

  desired_status = "RUNNING"

  allow_stopping_for_update = true
 
  //service_account {
  //  email = "99124858490-compute@developer.gserviceaccount.com"
  //  scopes = ["cloud-platform"]
  //}
}
