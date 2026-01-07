# Dev Environment

Example development environment consuming the `app-network` pattern module.

This environment demonstrates how application teams or service owners would
consume platform-provided Terraform patterns without interacting directly
with low-level infrastructure resources.

## What This Creates

- One VPC with public and private subnets
- Default application security group
- Opinionated networking baseline via `app-network` pattern

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

---

## Notes
- This environment is for demonstration purposes only.
- No resources should be defined directly in this directory.
- All infrastructure logic lives in pattern and foundation modules.
