# Launchpad

This repository contains the Terraform files to spin up infrastructure for
syoi.org. Currently, it is a single node setup hosted in a VM under proxmox VE.
The VM will be created through Proxmox Terraform provider and then provisioned
with Ansible for configuration.

## Getting Started

It is expected that Terraform is run inside the local network (same network as
proxmox VE). You may excute it from a server/PC machine inside the network or
run it in the bastion host.

This repository conforms to the standard Terraform workflow.

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

The state storage is on Terraform Cloud.
