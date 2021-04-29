// ubuntu 18.04
// m5a.large
// 2 cpus, 8gb ram, 20gbb hdd

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.65.0"
    }
  }
}

provider "google" {
  project = "cloud-course-4657313"
  region = "us-west1"
}

module "network" {
  source = "./network"
}

module "server" {
  source = "./servers"
  subnetwork = module.network.subnetwork_name
  address = module.network.ip_address
}
