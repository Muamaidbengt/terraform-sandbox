
locals {
  apps = tomap({
    hellocloud = {
      source_zip  = "./index.zip"
      name        = "hellocloud"
      entry_point = "helloGET"
    }
  })
}

module "source_storage" {
  source     = "./modules/source-storage"
  project_id = var.project_id
  prefix     = var.prefix
}

module "apps" {
  source       = "./modules/apps"
  for_each     = local.apps
  project_id   = var.project_id
  bucket       = module.source_storage.bucket
  source_zip   = each.value.source_zip
  name         = each.value.name
  entry_point  = each.value.entry_point
  prefix       = var.prefix
  terraform_sa = var.terraform_sa
}
