variable "project_name" {
  description = "Project name"
  type        = string
}

variable "env" {
  description = "Environment (dev, prod, etc.)"
  type        = string
}

variable "enable_versioning" {
  description = "Enable versioning on file storage bucket"
  type        = bool
  default     = true
}
