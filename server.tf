locals {
  image_family = var.project_id
}

resource "google_service_account" "instance_account" {
  account_id   = "k8s-practice-account"
  display_name = "Kubernetes practice service account"
}

resource "google_compute_instance" "server" {
  boot_disk {
    initialize_params {
      image = join("/", [local.image_family, var.image_name])
    }
    auto_delete = true
  }

  //tags = ["http-server","https-server"]
  machine_type = "e2-standard-2"
  name         = "k8s-server"
  zone         = "us-west1-a"
  network_interface {
    subnetwork = local.subnet_name
    //network = local.net_name
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
