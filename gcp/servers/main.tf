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

  //tags = ["http-server","https-server"]
  machine_type = "e2-standard-2"
  name = "k8s-practice-server"
  zone = "us-west1-a"
  network_interface {
    subnetwork = var.subnet_name
    //network = var.net_name
    access_config {
    }
  }

  //desired_status = "TERMINATED"

  allow_stopping_for_update = true
  //metadata = {
  //  ssh-keys = "user:${file("keys/id_gcp.pub")}"
  //}
 
  //service_account {
  //  email = "99124858490-compute@developer.gserviceaccount.com"
  //  scopes = ["cloud-platform"]
  //}
}

//data "google_service_account" "default" {
// account_id = 
//}

//resource "google_service_account" "default" {
//  account_id = data.google_service_account.default.name
//}

//variable "public_ip" {
//  type = string
//}
