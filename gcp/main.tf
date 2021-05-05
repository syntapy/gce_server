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
  region = "us-central1"
}

module "network" {
  source = "./network"
}

module "server" {
  source = "./servers"
  subnet_name = module.network.subnet_name
  net_name = module.network.net_name
}
