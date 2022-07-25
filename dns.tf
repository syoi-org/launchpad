data "cloudflare_zone" "syoi_org" {
  name = "syoi.org"
}

resource "cloudflare_record" "nomad" {
  zone_id = data.cloudflare_zone.syoi_org.id
  name    = "nomad.internal"
  value   = proxmox_vm_qemu.syoi2.default_ipv4_address
  type    = "A"
}

resource "cloudflare_record" "consul" {
  zone_id = data.cloudflare_zone.syoi_org.id
  name    = "consul.internal"
  value   = proxmox_vm_qemu.syoi2.default_ipv4_address
  type    = "A"
}

resource "cloudflare_record" "nomad_tailscale" {
  zone_id = data.cloudflare_zone.syoi_org.id
  name    = "nomad.ts"
  value   = data.tailscale_device.syoi2.addresses[0]
  type    = "A"
}

resource "cloudflare_record" "consul_tailscale" {
  zone_id = data.cloudflare_zone.syoi_org.id
  name    = "consul.ts"
  value   = data.tailscale_device.syoi2.addresses[0]
  type    = "A"
}
