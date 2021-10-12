terraform {
  backend "gcs" {
    bucket = "demo-terraform-state-42"
    prefix = "terraform/infra/state"
  }
}
