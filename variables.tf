# Authentication
variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
}

# Environment and Project Variables
variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = can(regex("^(dev|staging|prod)$", var.environment))
    error_message = "Environment must be dev, staging, or prod."
  }

}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "myproject"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "Project name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "application_name" {
  description = "Application name"
  type        = string
  default     = "webapp"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.application_name))
    error_message = "Application name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "application_version" {

  description = "The version of the application"
  type        = string
  default = "v0.1.0"

}

variable "ssh_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_key_path" {
  description = "Path to SSH private key"
  type        = string
  default     = "~/.ssh/id_rsa"
}


# Available Regions Variable
variable "available_regions" {
  description = "List of available DigitalOcean regions"
  type        = list(string)
  default     = ["nyc1", "nyc3", "ams3", "fra1", "lon1", "sgp1", "sfo3"]
}

# Region Selection Variable
variable "selected_region" {
  description = "Selected region from available regions"
  type        = string
  default     = "fra1"

  validation {
    condition     = contains(var.available_regions, var.selected_region)
    error_message = "Selected region must be one of the available regions: ${join(", ", var.available_regions)}"
  }
}

# Image Variables
variable "available_images" {
  description = "Available DigitalOcean images"
  type        = map(string)
  default = {
    ubuntu_20_04 = "ubuntu-20-04-x64"
    ubuntu_22_04 = "ubuntu-22-04-x64"
    debian_11    = "debian-11-x64"
    debian_12    = "debian-12-x64"
  }
}

variable "selected_image" {
  description = "Selected image from available images"
  type        = string
  default     = "ubuntu-22-04-x64"

  validation {
    condition     = contains(values(var.available_images), var.selected_image)
    error_message = "Selected image must be one of the available images: ${join(", ", values(var.available_images))}"
  }
}

# Network Variables
variable "vpc_ip_range" {
  description = "IP range for the VPC"
  type        = string
  default     = "10.10.10.0/24"
}

# Droplet Variables
variable "droplet_size" {
  description = "DigitalOcean droplet size"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "additional_tags" {
  description = "Additional tags for resources"
  type        = list(string)
  default     = []
}

variable "enable_backups" {
  description = "Enable automated backups"
  type        = bool
  default     = false
}

variable "monitoring" {
  description = "Enable monitoring"
  type        = bool
  default     = false
}