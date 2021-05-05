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

resource "google_compute_route" "route" {
  name = "route"
  network = google_compute_network.vpc_network.name
  dest_range = "0.0.0.0/0"
  //next_hop_ip = google_compute_subnetwork.vpc_subnet.gateway_address
  next_hop_gateway = "default-internet-gateway"
}

// Allow ssh into machine using gcloud ssh
resource "google_compute_firewall" "iap_allow" {
  name = "iap-allow"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  direction = "INGRESS"
  source_ranges = ["35.235.240.0/20"]
  priority = "1000"
}

resource "google_compute_firewall" "net_outbound" {
  name = "net-outbound"
  network = google_compute_network.vpc_network.name

  direction = "EGRESS"
  priority = "1000"

  allow {
    protocol = "all"
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "net_inbound" {
  name = "net-inbound"
  network = google_compute_network.vpc_network.name

  direction = "INGRESS"
  priority = "2000"

  deny {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

output "subnet_name" {
  value = google_compute_subnetwork.vpc_subnet.name
}

output "net_name" {
  value = google_compute_network.vpc_network.name
}

//output "public_ip" {
//  value = google_compute_address.public_ip.address
//}

//resource "google_compute_address" "public_ip" {
//  name = "public-ip"
//  address_type = "EXTERNAL"
//  purpose = "GCE_ENDPOINT"
//}

//output "local_ip" {
//  value = google_compute_subnetwork.vpc_network.ip_cidr_range
//}

//resource "google_compute_router" "router" {
//  name = "router"
//  network = google_compute_network.vpc_network.name
//}

//resource "google_compute_router_nat" "router_nat" {
//  name = "router-nat"
//  router = google_compute_router.router.name
//  region = google_compute_router.router.region
//}

//resource "google_compute_firewall" "net_inbound" {
//  name = "net-inbound"
//  network = google_compute_network.vpc_network.name

//  direction = "INGRESS"
//  priority = "2000"

//  deny {
//    protocol = "all"
//  }

//  log_config {
//    metadata = "INCLUDE_ALL_METADATA"
//  }
//}

//resource "google_compute_firewall" "deny_inbound" {
//  name = "deny-inbound"
//  network = google_compute_network.vpc_network.name

//  deny {
//    protocol = "all"
//  }

//  direction = "INGRESS"

//  log_config {
//    metadata = "INCLUDE_ALL_METADATA"
//  }

//  priority = "3000"
//}

//resource "google_compute_firewall" "https_outbound" {
//  name = "https-outbound"
//  network = google_compute_network.vpc_network.name

//  allow {
//    protocol = "tcp"
//    ports = ["80", "443"]
//  }

//  direction = "EGRESS"

//  log_config {
//    metadata = "INCLUDE_ALL_METADATA"
//  }
//}

//resource "google_compute_firewall" "deny_outbound" {
//  name = "https-outbound"
//  network = google_compute_network.vpc_network.name

//  allow {
//    protocol = "tcp"
//    ports = ["80", "443"]
//  }

//  direction = "EGRESS"

//  log_config {
//    metadata = "INCLUDE_ALL_METADATA"
//  }
//}
