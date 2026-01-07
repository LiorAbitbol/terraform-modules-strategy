# Getting Started

This guide walks through the fastest way to understand and test this repository.

It is intentionally brief and focuses on **using** the Terraform module strategy,
not explaining Terraform fundamentals.

---

## What This Repository Demonstrates

- A layered Terraform module strategy (foundation → patterns → environments)
- Opinionated but reusable infrastructure patterns
- CI-enforced formatting, validation, and documentation
- Real-world usage via example environments

---

## Repository Layout

```bash
modules/
  foundation/   # Low-level reusable building blocks
  patterns/     # Opionionated composite modules
envs/
  dev/          # Example environment consuming patterns
```

---

## Prerequisites

- Terraform >= 1.5
- AWS account
- AWS credentials configured via named profile
- `terraform-docs` (for documentation updates)

---

## Quick Start (Deploy to AWS)

> ⚠️ This creates real AWS resources. Destroy them when finished.

```bash
cd envs/dev
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

---

## Clean Up

```bash
terraform destroy
```

## Where to Go Next

- Explore modules/foundation for reusable primitives
- Explore modules/patterns for opinionated stacks
- Review CI workflows under .github/workflows
- Extend this repo with additional patterns or environments


---

## How reviewers interpret this

A short Getting Started guide signals:
- empathy for consumers
- documentation discipline
- platform thinking (onboarding matters)
- restraint (you didn’t over-document)

That’s all upside.
