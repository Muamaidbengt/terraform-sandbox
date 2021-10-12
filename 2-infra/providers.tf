terraform {
  required_version = ">= 0.13.0"

  required_providers {
    google = ">= 3.40.0"
  }
}

provider "google" {
  project      = var.project_id
  access_token = var.gcp_access_token
}
