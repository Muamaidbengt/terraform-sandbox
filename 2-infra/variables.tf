variable "gcp_access_token" {
  type        = string
  description = "GCP access token"
  default     = null
}

variable "project_id" {
  type        = string
  description = "Project ID"
  default     = "slask-project-42"
}

variable "terraform_sa" {
  type        = string
  description = "Terraform Service Account"
  default     = "terraform-deployer@slask-project-42.iam.gserviceaccount.com"
}

variable "prefix" {
  type        = string
  description = "Unique-ish prefix for resources"
  default     = "demo-42"
}
