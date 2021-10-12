# Terraform sandbox

## Usage

Using Chocolatey:

```powershell
cinst terraform --version 1.0.5
cinst gcloudsdk
```

### Step 1: Bootstrap

```powershell
gcloud auth application-default login
cd 1-bootstrap
terraform init
terraform plan
terraform apply
```

(uncomment lines in `backend.tf`)

```powershell
terraform init
terraform apply
```

Use the console to generate a Service Account key in JSON format. Store it as `d:\code\terraform-sandbox\sa-key.json`.

### Step 2: Infrastructure

```powershell
$env:GOOGLE_APPLICATION_CREDENTIALS = "d:\code\terraform-sandbox\sa-key.json"
cd 2-demo
Compress-Archive ..\helloworld-app\index.js index.zip -Force
terraform init
terraform plan
terraform apply
```
