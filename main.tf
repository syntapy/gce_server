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
