# System Patterns

*   **Architecture Overview:** The system being set up is a CI/CD pipeline connecting a GitHub repository (`https://github.com/ivanmolanski/agent-starter-pack`) to Google Cloud Platform (GCP) using Google Cloud Build. This setup is being performed **manually** following `deployment/README.md`. Terraform is used for Infrastructure as Code (IaC) to manage GCP resources (Cloud Build Triggers, potentially Artifact Registry, Cloud Run services, etc.) and the CI/CD infrastructure itself. Remote state for Terraform will be managed in a GCS bucket by default (created by Terraform).

    ```mermaid
    graph LR
        A[Developer] -- Push/PR --> B(GitHub Repo: agent-starter-pack);
        B -- Cloud Build Connection --> C(Cloud Build Trigger);
        C -- Starts Job --> D(Cloud Build);
        D -- Executes --> E(Terraform);
        E -- Manages --> F(GCP Resources);
        E -- Manages State --> G(GCS Bucket);
    ```

*   **Key Technical Decisions:**
    *   Follow the **manual** setup process outlined in `deployment/README.md`.
    *   Use GitHub (`https://github.com/ivanmolanski/agent-starter-pack`) as the source code repository.
    *   Use Google Cloud Build as the CI/CD platform, connected manually to the repository.
    *   Use Terraform for managing GCP infrastructure, configured via `env.tfvars`.
    *   Use Google Cloud Storage (GCS) for remote Terraform state management (default Terraform backend config).
    *   Use a single GCP project (`gen-lang-client-0926890286`) for CICD, Staging, and Production roles as specified by the user.
*   **Design Patterns:** Infrastructure as Code (IaC) using Terraform is the primary pattern. Event-driven architecture via Cloud Build Triggers responding to repository events.
*   **Component Interaction:**
    1.  **Manual Setup:**
        *   User connects the GitHub repository to Cloud Build via GCP Console/CLI.
        *   User configures `deployment/terraform/vars/env.tfvars` with project IDs and connection details.
        *   User runs `terraform init` and `terraform apply` locally to provision Cloud Build Triggers, IAM roles, GCS bucket for state, etc.
    2.  **Runtime CI/CD:**
        *   Code changes are pushed to GitHub or a Pull Request is created.
        *   The Cloud Build Connection notifies the appropriate Cloud Build Trigger.
        *   The Trigger activates based on the event (push to main, PR).
        *   Cloud Build executes a build pipeline (`pr_checks.yaml`, `staging.yaml`, `deploy-to-prod.yaml`), typically involving:
            *   Checking out code.
            *   Running tests (for PRs).
            *   Building container images and pushing to Artifact Registry.
            *   Deploying to Cloud Run or other target environments (Staging/Prod).
        *   Terraform might be invoked within Cloud Build for infrastructure adjustments if configured in build steps, reading state from the GCS bucket.
*   **Critical Paths:**
    *   **Setup Path:** Manual Connection -> `env.tfvars` config -> `terraform init` -> `terraform apply`.
    *   **CI Path:** Pull Request -> GitHub -> Cloud Build Connection -> Cloud Build Trigger (PR) -> Cloud Build Job (`pr_checks.yaml`).
    *   **CD Path (Staging):** Merge to `main` -> GitHub -> Cloud Build Connection -> Cloud Build Trigger (Push) -> Cloud Build Job (`staging.yaml`).
    *   **CD Path (Prod):** Successful Staging -> Manual Approval -> Cloud Build Trigger (Manual) -> Cloud Build Job (`deploy-to-prod.yaml`).
*   **Data Flow:**
    *   Source code flows from local development to GitHub, then pulled by Cloud Build during pipeline execution.
    *   Configuration data (Project IDs, repo details, connection name) flows from manual entry into `env.tfvars`.
    *   Terraform state data flows between local Terraform execution (during setup) and the GCS state bucket. During CI/CD, Cloud Build steps might interact with this state if Terraform is used in the pipeline.
