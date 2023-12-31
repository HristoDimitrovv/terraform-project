variable "approved_patches_am" {
  description = "The list of approved patches for the SSM baseline"
  type        = list(string)
  default     = []
}

variable "product_versions_am" {
  description = "The list of product versions for the SSM baseline"
  type        = list(string)
}

variable "patch_classification_am" {
  description = "The list of patch classifications for the SSM baseline"
  type        = list(string)
}

variable "patch_severity_am" {
  description = "The list of patch severities for the SSM baseline"
  type        = list(string)
}

variable "rejected_patches_am" {
  description = "The list of rejected patches for the SSM baseline"
  type        = list(string)
  default     = []
}

variable "scan_maintenance_window_schedule" {
  description = "The schedule of the install Maintenance Window in the form of a cron or rate expression"
  type        = string
}

variable "scan_maintenance_window_duration" {
  description = "The duration of the maintenence windows (hours)"
  type        = string
}

variable "scan_maintenance_window_cutoff" {
  description = "The number of hours before the end of the Maintenance Window that Systems Manager stops scheduling new tasks for execution"
  type        = string
}

variable "install_maintenance_window_schedule" {
  description = "The schedule of the install Maintenance Window in the form of a cron or rate expression"
  type        = string
}

variable "install_maintenance_window_duration" {
  description = "The duration of the maintenence windows (hours)"
  type        = string
}

variable "install_maintenance_window_cutoff" {
  description = "The number of hours before the end of the Maintenance Window that Systems Manager stops scheduling new tasks for execution"
  type        = string
}

variable "scan_max_concurrency" {
  description = "The maximum amount of concurrent instances of a task that will be executed in parallel"
  type        = string
}

variable "scan_max_errors" {
  description = "The maximum amount of errors that instances of a task will tolerate before being de-scheduled"
  type        = string
}

variable "install_max_concurrency" {
  description = "The maximum amount of concurrent instances of a task that will be executed in parallel"
  type        = string
}

variable "install_max_errors" {
  description = "The maximum amount of errors that instances of a task will tolerate before being de-scheduled"
  type        = string
}

variable "prefix" {
  description = "This name will prefix all resources, and be added as the value for the 'Name' tag where supported"
  type        = string
  default     = "hristo-dev-ssm"
}

