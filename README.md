# DigitalOcean Droplet Terraform Configuration
This Terraform configuration creates a DigitalOcean Droplet(VM) Infrastructure with the following components:
- VPC network
- Droplet (VM) with user data
- SSH key management
- Project organization
- Environment-based naming and environment specific variables

# Updated Directory Structure
```
terraform-droplet/
├── environments/
│   ├── dev/
│   │   └── terraform.tfvars
│   ├── staging/
│   │   └── terraform.tfvars
│   └── prod/
│   │   └── terraform.tfvars
│   └── globals.tfvars
├── main.tf
├── variables.tf
├── provider.tf
├── ssh.tf
├── outputs.tf
├── scripts/
│   └── user-data.sh
└── README.md
```

## Prerequisites

- Terraform installed (https://developer.hashicorp.com/terraform/install)
- DigitalOcean API token
- Git (optional)


## Environment-Specific Configurations

This project supports multiple environments with separate configurations:
- Development (dev)
- Staging
- Production (prod)

### Using Workspaces (Alternative Approach if your Terraform state is local)

You can also use Terraform workspaces to manage environments locally, it will keep Terraform state files isolated for different environments:

```bash
# Create different workspaces for each environment
terraform workspace new dev
terraform workspace new staging
terraform workspace new prod

# Select workspace
terraform workspace select dev

# Apply with environment-specific vars
terraform apply -var-file="environments/globals.tfvars" -var-file="environments/${terraform.workspace}/terraform.tfvars"
```
# List workspaces:
terraform workspace list

# Switch between workspaces:
terraform workspace select dev

# Check current workspace:
terraform workspace show


### Usage with Different Environments

1. Initialize Terraform:
```bash
# first export your DigitalOcean Token
export TF_VAR_do_token="your-do-token"
terraform init
```

2. To plan/apply for a specific environment:

For development:
```bash
terraform workspace select dev

terraform plan \
  -var-file="environments/globals.tfvars" \
  -var-file="environments/dev/terraform.tfvars"

terraform apply \
  -var-file="environments/globals.tfvars" \
  -var-file="environments/dev/terraform.tfvars"
```

For staging:
```bash
terraform workspace select staging

terraform plan \
  -var-file="environments/globals.tfvars" \
  -var-file="environments/staging/terraform.tfvars"

terraform apply \
  -var-file="environments/globals.tfvars" \
  -var-file="environments/staging/terraform.tfvars"
```

For production:
```bash
terraform workspace select prod

terraform plan \
  -var-file="environments/globals.tfvars" \
  -var-file="environments/prod/terraform.tfvars"

terraform apply \
  -var-file="environments/globals.tfvars" \
  -var-file="environments/prod/terraform.tfvars"
```


### Environment Variables

You can still override any variable using environment variables:

```bash
export TF_VAR_do_token="your-do-token"
export TF_VAR_environment="custom-env"
```

## Important Notes

1. Keep sensitive data out of tfvars files and use:
   - Environment variables
   - Encrypted secrets management
   - CI/CD pipeline variables

2. Never commit sensitive data to version control

3. Consider using remote state storage for team collaboration
```