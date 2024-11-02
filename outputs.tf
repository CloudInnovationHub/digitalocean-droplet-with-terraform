output "droplet_ip" {
  value = digitalocean_droplet.web.ipv4_address
}

output "vpc_ip_range" {
  value = digitalocean_vpc.web_vpc.ip_range
}

output "resource_names" {
  value = {
    project = digitalocean_project.project.name
    vpc     = digitalocean_vpc.web_vpc.name
    droplet = digitalocean_droplet.web.name
    ssh_key = local.is_dev_workspace ? digitalocean_ssh_key.default[0].name : data.digitalocean_ssh_key.existing[0].name
  }
}

output "connection_instructions" {
  value = <<EOF

=========== Connection Instructions ===========

Your Droplet has been successfully created!

Environment: ${var.environment}
Project: ${var.project_name}
Application: ${var.application_name}

To connect to your Droplet, use the following command:

    ssh -i ${var.ssh_private_key_path} root@${digitalocean_droplet.web.ipv4_address}

If you get a permissions error, run:
    chmod 600 ${var.ssh_private_key_path}

To verify the Hello World message from user data:
    ssh -i ${var.ssh_private_key_path} root@${digitalocean_droplet.web.ipv4_address} 'cat /root/hello.txt'

============================================
EOF
}