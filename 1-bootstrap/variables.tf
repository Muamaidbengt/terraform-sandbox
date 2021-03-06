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

variable "tf_state_bucket" {
  type        = string
  description = "Terraform state bucket"
  default     = "demo-terraform-state-42"
}
