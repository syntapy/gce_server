// ubuntu 18.04
// m5a.large
// 2 cpus, 8gb ram, 20gbb hdd

variable project_id {
  type = string
}

variable region {
  type = string
}

variable image_name {
  type = string
}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.74.0"
    }
  }
}

provider "google" {
  project = var.project_id 
  region = var.region
}

module "network" {
  source = "./network"
}

module "server" {
  source = "./servers"
  image_name = var.image_name
  image_family = var.project_id
  subnet_name = module.network.subnet_name
  net_name = module.network.net_name
}
