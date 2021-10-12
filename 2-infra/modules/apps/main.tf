# Source code for Hello world demo app
resource "google_storage_bucket_object" "app_source" {
  name   = "index.zip"
  bucket = var.bucket
  source = var.source_zip
}

# Service Account for executing the app
resource "google_service_account" "app_sa" {
  project      = var.project_id
  account_id   = "${var.prefix}-${var.name}-sa"
  display_name = "${var.name} Cloud Function Service Account"
}


# Grant IAM role for the Terraform SA to be able to deploy the function
resource "google_service_account_iam_member" "tf_deployer_sa_perms" {
  service_account_id = google_service_account.app_sa.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${var.terraform_sa}"
}

resource "google_cloudfunctions_function" "cloud_function" {
  project     = var.project_id
  description = "${var.name} function"
  runtime     = "nodejs14"
  name        = var.name
  region      = "europe-west1"

  available_memory_mb   = 128
  source_archive_bucket = var.bucket
  source_archive_object = google_storage_bucket_object.app_source.name
  trigger_http          = true
  entry_point           = var.entry_point

  service_account_email = google_service_account.app_sa.email
  depends_on = [
    # ensure permissions are set
    google_service_account_iam_member.tf_deployer_sa_perms
  ]
}

# Enable Hello world demo app to be invoked by anyone (i.e. without authentication)
resource "google_cloudfunctions_function_iam_member" "anonymousInvoker" {
  project        = google_cloudfunctions_function.cloud_function.project
  region         = google_cloudfunctions_function.cloud_function.region
  cloud_function = google_cloudfunctions_function.cloud_function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}
