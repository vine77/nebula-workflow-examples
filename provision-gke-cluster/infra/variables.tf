variable "gcp_region" {
  description = "The GCP region to deploy to"
  default = ""
}

variable "gcp_location" {
  description = "The GCP location to deploy to"
  default = ""
}

variable "gcp_project" {
  description = "The GCP project to deploy under"
  default = ""
}

variable "google-credentials" {
  description = "The Google credentials data to use for authentication"
  default     = ""
}

variable "initial_node_count" {
  description = "Number of worker VMs to initially create"
  default = 1
}

variable "master_username" {
  description = "Username for accessing the Kubernetes master endpoint"
  default = "k8smaster"
}

variable "master_password" {
  description = "Password for accessing the Kubernetes master endpoint"
  default = "k8smasterk8smaster"
}

variable "node_machine_type" {
  description = "GCE machine type"
  default = "n1-standard-1"
}

variable "node_disk_size" {
  description = "Node disk size in GB"
  default = "20"
}
