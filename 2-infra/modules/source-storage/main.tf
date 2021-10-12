# Storage bucket for Cloud Functions source code
resource "google_storage_bucket" "sources" {
  name    = "${var.prefix}-sources-bucket"
  project = var.project_id
}
