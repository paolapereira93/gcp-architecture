variable "project_name" {
    type = string
    default = "{{PROJECT_NAME}}"
}

variable "default_region" {
  type = string
  default  = "us-central1"
}

variable "default_zone" {
  type = string
  default  = "us-central1-b"
}

variable "user" {
  type = string
  default = "{{USER_EMAIL}}"
}
