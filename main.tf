locals {
  # Common tags for all resources
  common_tags = concat([
    var.environment,
    var.project_name,
    var.application_name
  ], var.additional_tags)

  # Resource naming prefix
  name_prefix = "${var.project_name}-${var.environment}-${var.application_name}"
}

# Create VPC
resource "digitalocean_vpc" "web_vpc" {
  name     = "${local.name_prefix}-vpc"
  region   = var.selected_region
  ip_range = var.vpc_ip_range
}

# Create a new Droplet
resource "digitalocean_droplet" "web" {
  name     = "${local.name_prefix}-droplet"
  image    = var.selected_image
  region   = var.selected_region
  size     = var.droplet_size
  vpc_uuid = digitalocean_vpc.web_vpc.id
  ssh_keys = [local.ssh_key_fingerprint]

  backups    = var.enable_backups
  monitoring = var.monitoring
  tags       = local.common_tags

  user_data = templatefile("${path.module}/cloud-init/user-data.sh", {
    ENVIRONMENT     = var.environment
    PROJECT_NAME    = var.project_name
    APPLICATION_NAME = var.application_name
    APPLICATION_VERSION = var.application_version
  })
}

# Create a project
  locals {
  environment_map = {
    dev  = "Development"
    staging = "Staging"
    prod  = "Production"
  }
  }
resource "digitalocean_project" "project" {
  name        = local.name_prefix
  description = "Project for ${var.project_name} ${var.application_name} in ${var.environment}"
  purpose     = "Web Application"
  environment = local.environment_map[var.environment]
  resources   = [digitalocean_droplet.web.urn]
}
