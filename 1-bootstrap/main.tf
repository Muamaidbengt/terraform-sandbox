locals {
  sa_iam_permissions = [
    "roles/iam.securityAdmin",
    "roles/storage.admin",
    "roles/cloudfunctions.admin",
    "roles/iam.serviceAccountAdmin"
  ]
}

# Terraform Service Account (SA) to use henceforth
resource "google_service_account" "terraform_sa" {
  project      = var.project_id
  account_id   = "terraform-deployer"
  display_name = "Terraform Service Account"
}

# Storage bucket for storing Terraform State
resource "google_storage_bucket" "terraform_state" {
  project                     = var.project_id
  name                        = var.tf_state_bucket
  location                    = "EU"
  force_destroy               = false
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}

# IAM Permissions on project for Terraform SA
resource "google_project_iam_member" "tf_deployer_sa_perms" {
  for_each = toset(local.sa_iam_permissions)
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.terraform_sa.email}"
}
