# Terraform sandbox

## Usage

Using Chocolatey:

```powershell
cinst terraform --version 1.0.5
```

Then:

```powershell
$env:GOOGLE_APPLICATION_CREDENTIALS = "c:\path\to\service-key.json"
terraform init
terraform plan
terraform apply
```
