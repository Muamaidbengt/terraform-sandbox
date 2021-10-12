# Terraform sandbox

## Usage

Using Chocolatey:

```powershell
cinst terraform --version 1.0.5
cinst gcloudsdk
```

Then:

```powershell
gcloud auth application-default login
cd 1-bootstrap
terraform init
terraform plan
terraform apply
```

```powershell
$env:GOOGLE_APPLICATION_CREDENTIALS = "c:\path\to\service-key.json"
cd 2-demo
terraform init
terraform plan
terraform apply
```
