terraform {
  required_version = ">= 0.11.11"
  backend "gcs" {
    bucket = "sandbox"
    prefix = "demo"
  }
}

provider "google" {
  credentials = "${var.google-credentials}"
  project     = "${local.workspace["gcp_project"]}"
  region      = "${local.workspace["gcp_region"]}"
}

resource "google_container_cluster" "k8sexample" {
  name               = "k8sexample-k8s-cluster"
  description        = "example k8s cluster"
  location           = "${local.workspace["gcp_location"]}"
  initial_node_count = "${var.initial_node_count}"
  enable_kubernetes_alpha = "true"
  enable_legacy_abac = "true"

  master_auth {
    username = "${var.master_username}"
    password = "${var.master_password}"

    client_certificate_config {
      issue_client_certificate = true
    }
  }

  node_config {
    machine_type = "${var.node_machine_type}"
    disk_size_gb = "${var.node_disk_size}"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
  }
}
