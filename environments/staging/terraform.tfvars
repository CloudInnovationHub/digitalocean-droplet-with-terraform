environment      = "staging"
selected_region  = "fra1"
selected_image   = "ubuntu-22-04-x64"
vpc_ip_range     = "10.20.20.0/24"
droplet_size     = "s-2vcpu-2gb"

# Staging-specific tags
additional_tags  = ["staging", "pre-production"]