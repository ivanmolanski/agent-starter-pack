# Progress Tracker

*   **Current Status:** Completed CI/CD setup for `coding-crew-agent` and local setup verification for all four agent types.
*   **Completed Steps:**
    *   **CI/CD Setup (Manual for `coding-crew-agent`):**
        *   Confirmed prerequisites (gcloud auth, gh auth, Terraform install).
        *   User manually connected GitHub repo (`ivanmolanski/agent-starter-pack`) to Cloud Build (connection: `git-agent-starter-pack`).
        *   Configured `coding-crew-agent/deployment/terraform/vars/env.tfvars` for single project (`gen-lang-client-0926890286`).
        *   Ran `terraform init` successfully in `coding-crew-agent/deployment/terraform/`.
        *   Troubleshooted and resolved Terraform "Already Exists" errors for BigQuery datasets by:
            *   Manually deleting potentially conflicting datasets (`coding_crew_agent_telemetry`, `coding_crew_agent_feedback`) using `gcloud alpha bq datasets delete`.
            *   Modifying `coding-crew-agent/deployment/terraform/log_sinks.tf` to remove `for_each` loops and correctly reference the single project ID.
            *   Running `terraform refresh` to sync state.
        *   Successfully ran `terraform apply` to provision the remaining CI/CD infrastructure.
        *   Removed committed GitHub PAT from `InstructuonsCLine.txt`.
        *   Corrected Git history by resetting the bad commit and creating a new clean commit excluding the file with the PAT.
        *   Successfully pushed the clean commit to `origin/main` on GitHub.
    *   **Agent Project Setup & Verification:**
        *   Successfully created/recreated agent projects: `coding-crew-agent`, `langgraph-agent`, `agentic-agent`, `live-api-agent`.
        *   Successfully ran `make install` for all four agent projects to install dependencies.
        *   Resolved `sqlite3` version conflict for `coding-crew-agent` by installing `pysqlite3-binary` and adding override code to `frontend/streamlit_app.py`.
        *   Started `coding-crew-agent` backend (deployed to Agent Engine via `make backend`).
        *   Started local playgrounds/servers for all agents:
            *   `coding-crew-agent` frontend (`make playground` on `http://localhost:8501`, connects to Agent Engine backend).
            *   `langgraph-agent` playground (`make playground` on `http://localhost:8502`).
            *   `agentic-agent` playground (`make playground` on `http://localhost:8504`).
            *   `live-api-agent` backend (`uvicorn` on port 8000) and frontend (`npm start` on `http://localhost:3000`) started separately after resolving port conflicts.
    *   **Configuration:**
        *   Created/Updated `.env` files in all four agent directories (`coding-crew-agent`, `langgraph-agent`, `agentic-agent`, `live-api-agent`) with user-provided `GOOGLE_API_KEY`, `PRIMARY_MODEL`, `EMBEDDING_MODEL`, and base URLs.
    *   **Package Updates:**
        *   Updated Python dependencies to latest versions using `uv pip install --upgrade` and regenerated `uv.lock` files for all four agent projects.
*   **Next Steps:**
    *   Local playgrounds/servers are running. User can interact with them.
    *   CI/CD pipeline for `coding-crew-agent` is active on GitHub.
    *   Further agent-specific setup (e.g., data ingestion for `agentic-agent`) might be needed for full functionality.
