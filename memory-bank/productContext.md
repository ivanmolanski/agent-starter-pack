# Product Context

*   **Problem Space:** The user needs a standardized and automated way to set up a CI/CD pipeline for future AI agent projects based on the Agent Starter Pack framework, connecting GitHub to Google Cloud Build.
*   **Target Users:** The primary user is the developer (ivanmolanski) setting up their development and deployment infrastructure.
*   **Core Functionality:** The system should automate the creation and configuration of:
    *   A GitHub repository (or connection to an existing one).
    *   Google Cloud Build connection to GitHub.
    *   Cloud Build triggers for CI (PR checks) and CD (deployment).
    *   Underlying infrastructure via Terraform (IAM, secrets, potentially dev/staging/prod resources).
    *   Terraform state management (GCS bucket).
*   **User Experience Goals:** The setup should be achievable via a single CLI command (`agent-starter-pack setup-cicd`) with clear prompts or parameters. It should result in a ready-to-use CI/CD environment requiring minimal manual intervention post-setup (just committing/pushing code).
*   **Success Metrics:** Successful execution of the `setup-cicd` command, creation of the necessary cloud and GitHub resources, and readiness for code commit/push to trigger the pipeline.
