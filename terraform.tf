terraform {
  cloud {
    organization = "syoi-org"

    workspaces {
      name = "launchpad"
    }
  }
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = ">= 2.9.5"
    }
    tailscale = {
      source  = "davidsbond/tailscale"
      version = ">= 0.12.2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 3.19.0"
    }
  }
}
