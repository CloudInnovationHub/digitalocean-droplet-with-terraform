environment      = "prod"
selected_region  = "fra1"
selected_image   = "ubuntu-22-04-x64"
vpc_ip_range     = "10.30.30.0/24"
droplet_size     = "s-2vcpu-2gb"

# Production-specific tags
additional_tags  = ["production", "customer-facing"]

# Production-specific backup and monitoring settings
enable_backups   = true
monitoring       = true