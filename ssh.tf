locals {
  ssh_key_name = "${var.project_name}-sshkey"
  is_dev_workspace = terraform.workspace == "dev"
  ssh_key_fingerprint = local.is_dev_workspace ? digitalocean_ssh_key.default[0].fingerprint : data.digitalocean_ssh_key.existing[0].fingerprint
}

# Read the existing public key
data "local_file" "ssh_public_key" {
  filename = pathexpand(var.ssh_key_path)
}

# Only create SSH key in dev workspace
resource "digitalocean_ssh_key" "default" {
  count      = local.is_dev_workspace ? 1 : 0
  name       = local.ssh_key_name
  public_key = data.local_file.ssh_public_key.content

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      public_key
    ]
  }
}

# Data source to read existing SSH key in other workspaces
data "digitalocean_ssh_key" "existing" {
  count = local.is_dev_workspace ? 0 : 1
  name  = local.ssh_key_name
}

# Local to get the correct SSH key ID regardless of workspace
locals {
  ssh_key_id = local.is_dev_workspace ? digitalocean_ssh_key.default[0].id : data.digitalocean_ssh_key.existing[0].id
}