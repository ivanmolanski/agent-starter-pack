# Technical Context

*   **Core Technologies:**
    *   Google Cloud Platform (GCP) for cloud infrastructure.
    *   Google Cloud Build for CI/CD execution.
    *   GitHub for source code management.
    *   Terraform for Infrastructure as Code (IaC).
    *   Python (primarily for the `agent-starter-pack` tool itself).
*   **Development Environment:**
    *   OS: Linux (running in `/home/codespace`).
    *   Shell: `/bin/bash`.
    *   Python: 3.12.1 (via `venv`).
    *   Required Tools:
        *   `agent-starter-pack` CLI (v0.2.2 installed via `pipx`).
        *   `gcloud` CLI (authenticated via `gcloud auth application-default login`, project `gen-lang-client-0926890286` set).
        *   `gh` CLI (requires `gh auth login`).
        *   Terraform (must be installed).
*   **Build & Deployment:**
    *   **Manual Setup:** Infrastructure (Cloud Build Triggers, IAM, GCS state bucket) is provisioned locally using `terraform init` and `terraform apply` in `deployment/terraform/` after configuring `env.tfvars`.
    *   **CI/CD Execution:** Cloud Build pipelines (`pr_checks.yaml`, `staging.yaml`, `deploy-to-prod.yaml`) are triggered by GitHub events (PRs, pushes) via the manually configured Cloud Build Connection. These pipelines handle testing, building artifacts (e.g., Docker images), pushing to Artifact Registry, and deploying to target environments (e.g., Cloud Run).
*   **Key Dependencies:**
    *   External Services: GitHub (`https://github.com/ivanmolanski/agent-starter-pack`), Google Cloud Platform (Cloud Build, IAM, GCS, Secret Manager, Resource Manager, potentially Artifact Registry, Cloud Run).
    *   CLI Tools: `gcloud`, `terraform`. (`gh` needed for manual connection setup by user, `agent-starter-pack` CLI not used for this manual process).
*   **Technical Constraints:**
    *   Requires manual connection of GitHub repo to Cloud Build.
    *   Requires manual configuration of `deployment/terraform/vars/env.tfvars`.
    *   Requires manual execution of `terraform init` and `terraform apply`.
    *   Requires user to have appropriate permissions in GCP project (`gen-lang-client-0926890286`) to enable APIs and run Terraform.
*   **Tooling:**
    *   `gcloud`: GCP interaction, authentication, API enablement.
    *   `terraform`: Infrastructure provisioning and management.
*   **API Integrations:**
    *   Terraform interacts with GCP APIs (Cloud Build, IAM, GCS, etc.) via `gcloud` credentials.
    *   Cloud Build connects to GitHub via the manually established connection (likely OAuth or GitHub App based on user setup).
*   **Troubleshooting:** Common issues and solutions related to authentication (GCP credentials, Vertex AI API enablement, permissions), Terraform setup, and project creation failures are documented in `/workspaces/agent-starter-pack/InstructuonsCLine.txt` and the `deployment/README.md`. Refer to those files and official GCP documentation if issues arise.
