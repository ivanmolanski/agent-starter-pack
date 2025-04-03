# Agent Starter Pack Project Summary

## Project Overview

This project utilizes the `agent-starter-pack`, a collection of production-ready Generative AI Agent templates built for Google Cloud. Its goal is to accelerate the development and deployment of GenAI agents by providing pre-built templates, CI/CD infrastructure, monitoring, evaluation tools, and interactive playgrounds.

## Solutioning & Environment

The project involved manually setting up the Continuous Integration/Continuous Deployment (CI/CD) pipeline for the `coding-crew-agent`, preparing the foundation for deploying agents. This was achieved using:

*   **Terraform:** Infrastructure as Code (IaC) tool used to provision Google Cloud resources. The setup involved running `terraform init` and `terraform apply` within the `coding-crew-agent/deployment/terraform/` directory after configuring environment variables (`env.tfvars`) for the target GCP project (`gen-lang-client-0926890286`). This provisioned resources like Cloud Build triggers, IAM roles, a GCS bucket for Terraform state, and BigQuery datasets for telemetry and feedback. Troubleshooting involved resolving Terraform state conflicts and correcting resource definitions (`log_sinks.tf`).
*   **GitHub & Cloud Build:** The source code is hosted on GitHub (`ivanmolanski/agent-starter-pack`). A manual connection was established between this repository and Google Cloud Build (`connection: git-agent-starter-pack`) to enable CI/CD triggers. A GitHub Personal Access Token (PAT) was initially committed accidentally but was subsequently removed, and the Git history was corrected before pushing cleanly.
*   **Google Cloud Platform (GCP):** The core infrastructure (Cloud Build, IAM, GCS, BigQuery, Artifact Registry) resides in the `gen-lang-client-0926890286` GCP project. Agents are designed to be deployed to either **Google Cloud Run** or **Vertex AI Agent Engine**.
*   **Local Environment:** Development and testing occur locally (within this codespace environment), using tools like `make`, `uv` (Python package manager), `gcloud`, and `docker` (implicitly for builds).

## Agent Capabilities & Invocation

The starter pack provides several agent templates, each with specific capabilities and invocation methods:

1.  **`agentic-agent`:**
    *   **Capability:** A Retrieval-Augmented Generation (RAG) agent using LangGraph for document retrieval (from Vertex AI Search or Vector Search) and question answering. Includes a data ingestion pipeline.
    *   **Invocation (Local):** `make playground` (Starts a Streamlit UI on `http://localhost:8504`).
    *   **Invocation (Deployed):** `make backend` (Deploys to Vertex AI Agent Engine).

2.  **`coding-crew-agent`:**
    *   **Capability:** A multi-agent system implemented with CrewAI, designed to assist with coding tasks.
    *   **Invocation (Local):** `make playground` (Starts a Streamlit UI on `http://localhost:8501`, connects to the Agent Engine backend).
    *   **Invocation (Deployed):** `make backend` (Deploys to Vertex AI Agent Engine). *CI/CD is fully set up for this agent.*

3.  **`langgraph-agent`:**
    *   **Capability:** Implements a base ReAct (Reasoning and Acting) agent pattern using LangGraph.
    *   **Invocation (Local):** `make playground` (Starts a Streamlit UI on `http://localhost:8502`).
    *   **Invocation (Deployed):** `make backend` (Deploys to Vertex AI Agent Engine).

4.  **`live-api-agent`:**
    *   **Capability:** A real-time multimodal RAG agent using the Gemini Live API. Supports audio, video, and text chat, retrieving information from a vector database.
    *   **Invocation (Local):** `make playground` (Starts a FastAPI backend on port 8000 and a React frontend on port 3000). Can also run backend (`make backend`) and frontend (`make ui`) separately.
    *   **Invocation (Deployed):** `gcloud run deploy --source .` (Deploys directly to Google Cloud Run).

## End-to-End Flow

The typical workflow facilitated by the starter pack (and partially set up in this project) is:

1.  **Initialization:** Create a new agent project using `agent-starter-pack create` or clone the repository.
2.  **Setup:** Install dependencies (`make install`). Configure environment variables (`.env` files, Terraform `env.tfvars`).
3.  **Development:** Prototype agent logic (e.g., in `notebooks/`) and integrate it into the core application (`app/agent.py`).
4.  **Local Testing:** Run the agent locally using `make playground` (or specific `make backend`/`make ui` commands) to interact via the provided frontend (Streamlit or React).
5.  **CI/CD Setup:** Configure and deploy the CI/CD infrastructure using Terraform (as done manually for `coding-crew-agent`) or the `agent-starter-pack setup-cicd` command.
6.  **Code Push:** Commit and push code changes to the connected GitHub repository.
7.  **CI Pipeline:** Cloud Build triggers (e.g., on Pull Requests) run linters and tests (`pr_checks.yaml`).
8.  **CD Pipeline:** On merging to the main branch, Cloud Build triggers (`staging.yaml`, `deploy-to-prod.yaml`) build container images, push them to Google Artifact Registry, and deploy the agent application to the target environment (Cloud Run or Agent Engine).
9.  **Monitoring:** The deployed application uses OpenTelemetry to send logs and traces to Google Cloud Logging and Cloud Trace. Data is also stored in BigQuery for long-term analysis, visualized via a Looker Studio dashboard.
10. **Iteration:** Use monitoring data and user feedback (collected via the playground UI) to improve the agent.
