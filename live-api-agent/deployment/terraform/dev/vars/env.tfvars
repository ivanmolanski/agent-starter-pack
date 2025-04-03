# Project name used for resource naming
project_name = "live-api-agent"

# Your Dev Google Cloud project id
dev_project_id = "your-dev-project-id"

# The Google Cloud region you will use to deploy the infrastructure
region = "us-central1"

telemetry_logs_filter = "jsonPayload.attributes.\"traceloop.association.properties.log_type\"=\"tracing\" jsonPayload.resource.attributes.\"service.name\"=\"live-api-agent\""
feedback_logs_filter = "jsonPayload.log_type=\"feedback\""
