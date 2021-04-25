resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
  delete_default_routes_on_create = true
}

resource "google_compute_subnetwork" "vpc_subnet" {
  name = "vpc-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region = "us-west1"
  network = google_compute_network.vpc_network.name
}

output "subnetwork_name" {
  value = google_compute_subnetwork.vpc_subnet.name
}

resource "google_compute_firewall" "iap_allow" {
  name = "iap-allow"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  direction = "INGRESS"
  source_ranges = ["35.235.240.0/20"]
}
