output "terraform_sa_email" {
  description = "Email of Terraform Service Account"
  value       = google_service_account.terraform_sa.email
}
