
# Generate Tailscale key for joining Tailscale VPN
resource "tailscale_tailnet_key" "syoi2_key" {
  reusable  = true
  ephemeral = false
  tags      = ["tag:syoi2"]
}

# The VM machine that hosts the single node Nomad cluster
resource "proxmox_vm_qemu" "syoi2" {
  name = "syoi2"
  desc = "SYOI Server"

  target_node = "pve"
  vmid        = 505

  clone      = "fedora-cloudinit"
  full_clone = false

  bios  = "ovmf"
  agent = 1

  memory  = 4096
  balloon = 2048
  sockets = 1
  cores   = 4
  cpu     = "host"
  scsihw  = "virtio-scsi-pci"

  disk {
    type    = "scsi"
    storage = "local-lvm"
    size    = "64G"
    format  = "raw"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  os_type = "cloud-init"
  ciuser  = "stommydx"
  sshkeys = file("~/.ssh/id_ed25519.pub")

  automatic_reboot = false

  # Call provisioning script to configure the VM with ansible
  provisioner "local-exec" {
    command     = "./provision.sh --extra-vars tailscale_auth_key=${tailscale_tailnet_key.syoi2_key.key} ${self.default_ipv4_address}"
    working_dir = "${path.module}/ansible"
  }
}

# Read Tailscale IP from Tailscale API
data "tailscale_device" "syoi2" {
  depends_on = [
    proxmox_vm_qemu.syoi2
  ]
  name     = "syoi2.syoi-org.org.github"
  wait_for = "120s"
}
