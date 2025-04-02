# Active Context

*   **Current Focus:** Manually setting up the CI/CD environment following the `deployment/README.md` instructions provided by the user.
*   **Recent Changes:**
    *   Attempted to use `agent-starter-pack setup-cicd` command multiple times, missing prerequisites (Terraform install) and misinterpreting user intent.
    *   User clarified the requirement is to follow the **manual** setup steps from the provided documentation.
    *   Updated `projectbrief.md` to reflect the manual setup goal.
*   **Next Steps:**
    1.  Update remaining Memory Bank files (`activeContext.md`, `systemPatterns.md`, `techContext.md`, `progress.md`) for the manual approach.
    2.  Ensure prerequisites are met (GCP Project IDs confirmed, Terraform installed, check required APIs).
    3.  Guide user through connecting the repository (`https://github.com/ivanmolanski/agent-starter-pack`) to Cloud Build (Step 2 of manual guide).
    4.  Configure Terraform variables in `deployment/terraform/vars/env.tfvars` (Step 3).
    5.  Run `terraform init` and `terraform apply` in `deployment/terraform/` (Step 4).
    6.  Document outcome in `progress.md`.
*   **Active Decisions:** Switched from automated `setup-cicd` command to manual setup process based on user feedback and provided documentation.
*   **Key Patterns/Preferences:** Adhere strictly to the manual setup steps outlined in the provided `deployment/README.md` documentation. Use the confirmed GCP project ID (`gen-lang-client-0926890286`) for CICD, Staging, and Prod roles. Use the specified GitHub repo (`https://github.com/ivanmolanski/agent-starter-pack`).
*   **Learnings/Insights:** Critical to follow user-provided documentation precisely, especially when differentiating between automated scripts and manual procedures. The `setup-cicd` command is explicitly noted as experimental and not for production, aligning with the user's preference for the manual approach.
