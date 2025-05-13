variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
  default     = "finalexam422"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "us-central1-a"
}

variable "db_username" {
  description = "Username to use for the database"
  type = string
  default = "user"
}

variable "db_password" {
  description = "Password to use for the databases"
  type = string
  default = "password"
}

variable "db_name" {
  description = "Name of the database to use"
  type = string
  default = "gallery"
}