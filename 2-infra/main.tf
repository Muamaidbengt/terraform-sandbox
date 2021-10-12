
# Storage bucket for Cloud Functions source code
resource "google_storage_bucket" "sources" {
  name    = "hello-demo-bucket-42"
  project = var.project_id
}

# Source code for Hello world demo app
resource "google_storage_bucket_object" "helloworld" {
  name   = "index.zip"
  bucket = google_storage_bucket.sources.name
  source = "./index.zip"
}

# Service Account for executing the Hello world demo app
resource "google_service_account" "helloworld_sa" {
  project      = var.project_id
  account_id   = "demo-42-helloworld-sa"
  display_name = "Hello world Cloud Function Service Account"
}

# Grant IAM role for the Terraform SA to be able to deploy the function
resource "google_service_account_iam_member" "tf_deployer_sa_perms" {
  service_account_id = google_service_account.helloworld_sa.name
  role     = "roles/iam.serviceAccountUser"
  member   = "serviceAccount:${var.terraform_sa}"
}

# Hello world demo app
resource "google_cloudfunctions_function" "demo_function" {
  project     = var.project_id
  description = "Hello World demo function"
  runtime     = "nodejs14"
  name        = "hello-demo"
  region      = "europe-west1"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.sources.name
  source_archive_object = google_storage_bucket_object.helloworld.name
  trigger_http          = true
  entry_point           = "helloGET"

  service_account_email = google_service_account.helloworld_sa.email
  depends_on = [
    # ensure permissions are set
    google_service_account_iam_member.tf_deployer_sa_perms
  ]
}

# Enable Hello world demo app to be invoked by anyone (i.e. without authentication)
resource "google_cloudfunctions_function_iam_member" "helloInvoker" {
  project        = google_cloudfunctions_function.demo_function.project
  region         = google_cloudfunctions_function.demo_function.region
  cloud_function = google_cloudfunctions_function.demo_function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}
