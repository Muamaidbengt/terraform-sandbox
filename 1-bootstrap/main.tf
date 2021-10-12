locals {
  sa_iam_permissions = [
    "roles/iam.securityAdmin"
  ]
}

resource "google_service_account" "terraform_sa" {
  project      = var.project_id
  account_id   = "terraform-deployer"
  display_name = "Terraform Service Account"
}

resource "google_storage_bucket" "terraform_state" {
  project                     = var.project_id
  name                        = "demo-terraform-state-42"
  location                    = "EU"
  force_destroy               = false
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}

resource "google_project_iam_member" "tf_deployer_sa_perms" {
  for_each = toset(local.sa_iam_permissions)
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.terraform_sa.email}"
}
