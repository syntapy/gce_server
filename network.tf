resource "google_compute_network" "vpc_network" {
  name                            = "vpc-network"
  delete_default_routes_on_create = true
}

resource "google_compute_subnetwork" "vpc_subnet" {
  name          = "vpc-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = "us-west1"
  network       = google_compute_network.vpc_network.name
}

resource "google_compute_route" "route" {
  name             = "route"
  network          = google_compute_network.vpc_network.name
  dest_range       = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway"
}

// Allow ssh into machine using gcloud ssh
resource "google_compute_firewall" "iap_allow" {
  name    = "iap-allow"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  direction     = "INGRESS"
  source_ranges = ["35.235.240.0/20"]
  priority      = "1000"
}

resource "google_compute_firewall" "net_outbound" {
  name    = "net-outbound"
  network = google_compute_network.vpc_network.name

  direction = "EGRESS"
  priority  = "1000"

  allow {
    protocol = "all"
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "net_inbound" {
  name    = "net-inbound"
  network = google_compute_network.vpc_network.name

  direction = "INGRESS"
  priority  = "2000"

  deny {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

locals {
  subnet_name = google_compute_subnetwork.vpc_subnet.name
  net_name    = google_compute_network.vpc_network.name
}
