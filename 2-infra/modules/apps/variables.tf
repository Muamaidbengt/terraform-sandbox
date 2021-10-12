variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "bucket" {
  type        = string
  description = "Bucket for storing sources"
}

variable "source_zip" {
  type        = string
  description = "path to ZIP file containing app source code"
}

variable "name" {
  type        = string
  description = "name of the app"
}

variable "prefix" {
  type        = string
  description = "Unique-ish prefix for resources"
}

variable "terraform_sa" {
  type        = string
  description = "Service Account"
}

variable "entry_point" {
  type        = string
  description = "Entry point for the app"
}
