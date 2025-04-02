# Copyright 2025 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Note: Removed for_each as only one project ID is used for staging/prod/cicd
resource "google_bigquery_dataset" "feedback_dataset" {
  project       = var.cicd_runner_project_id # Use the single project ID
  dataset_id    = replace("${var.project_name}_feedback", "-", "_")
  friendly_name = "${var.project_name}_feedback"
  location      = var.region
  depends_on    = [resource.google_project_service.cicd_services, resource.google_project_service.shared_services]
}

# Note: Removed for_each as only one project ID is used for staging/prod/cicd
resource "google_bigquery_dataset" "telemetry_logs_dataset" {
  project       = var.cicd_runner_project_id # Use the single project ID
  dataset_id    = replace("${var.project_name}_telemetry", "-", "_")
  friendly_name = "${var.project_name}_telemetry"
  location      = var.region
  depends_on    = [resource.google_project_service.cicd_services, resource.google_project_service.shared_services]
}

# Note: Removed for_each as only one project ID is used for staging/prod/cicd
module "log_export_to_bigquery" {
  source  = "terraform-google-modules/log-export/google"
  version = "10.0.0"

  log_sink_name          = "${var.project_name}_telemetry"
  parent_resource_type   = "project"
  parent_resource_id     = var.cicd_runner_project_id # Use the single project ID
  destination_uri        = "bigquery.googleapis.com/projects/${var.cicd_runner_project_id}/datasets/${google_bigquery_dataset.telemetry_logs_dataset.dataset_id}" # Reference single dataset
  filter                 = var.telemetry_logs_filter
  bigquery_options       = { use_partitioned_tables = true }
  unique_writer_identity = true
  depends_on             = [google_bigquery_dataset.telemetry_logs_dataset]
}

# Note: Removed for_each as only one project ID is used for staging/prod/cicd
module "feedback_export_to_bigquery" {
  source                 = "terraform-google-modules/log-export/google"
  version                = "10.0.0"
  log_sink_name          = "${var.project_name}_feedback"
  parent_resource_type   = "project"
  parent_resource_id     = var.cicd_runner_project_id # Use the single project ID
  destination_uri        = "bigquery.googleapis.com/projects/${var.cicd_runner_project_id}/datasets/${google_bigquery_dataset.feedback_dataset.dataset_id}" # Reference single dataset
  filter                 = var.feedback_logs_filter
  bigquery_options       = { use_partitioned_tables = true }
  unique_writer_identity = true
  depends_on             = [google_bigquery_dataset.feedback_dataset]
}

# Note: Removed for_each and adjusted member reference
resource "google_project_iam_member" "bigquery_data_editor_telemetry" {
  project = var.cicd_runner_project_id # Use the single project ID
  role    = "roles/bigquery.dataEditor"
  member  = module.log_export_to_bigquery.writer_identity # Reference single module output
}

# Note: Removed for_each and adjusted member reference
resource "google_project_iam_member" "bigquery_data_editor_feedback" {
  project = var.cicd_runner_project_id # Use the single project ID
  role    = "roles/bigquery.dataEditor"
  member  = module.feedback_export_to_bigquery.writer_identity # Reference single module output
}
