locals {
  # Workaround for https://github.com/hashicorp/terraform/issues/15966
  workspace-settings = {
    file = "workspace.${terraform.workspace}.tfvars.json"

    defaults = {
	gcp_region = ""
	gcp_location = ""
	gcp_project = ""
    }
  }

  workspace = "${merge(local.workspace-settings.defaults, jsondecode(fileexists(local.workspace-settings.file) ? file(local.workspace-settings.file) : "{}"))}"
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
