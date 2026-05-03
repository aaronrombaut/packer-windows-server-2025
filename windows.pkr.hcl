packer {
  required_plugins {
    vsphere = {
      source  = "github.com/hashicorp/vsphere"
      version = ">= 1.0.0"
    }
  }
}

source "vsphere-iso" "windows" {
  vcenter_server       = "vcsa-v107-10.lab.aaronrombaut.com"
  username             = "administrator@vsphere.local"
  password             = "IT$h0uldB$3cure!"
  insecure_connection  = false

  datacenter           = "New York"
  cluster              = "Home Lab Cluster"
  datastore            = "virtual-machines"

  vm_name              = "win2025-test"
  guest_os_type        = "windows2019srvNext_64Guest"

  CPUs                 = 2
  RAM                  = 8192

  firmware             = "efi-secure"
  vm_version           = 19
  boot_wait             = "3s"
  boot_command = [
    "<enter>"
  ]

  network_adapters {
    network = "dvPG-VLAN107-VM Management"
    network_card = "vmxnet3"
  }

  disk_controller_type = ["pvscsi"]
  storage {
    disk_size             = 40960
    disk_thin_provisioned = true
  }

  iso_paths = [
    "[dml] 26100.32230.260111-0550.lt_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso",
    "[dml] VMware-tools-windows-13.0.10-25056151.iso"
  ]

  cd_files = [
    "/home/arombaut/packer/packer-windows-server-2025/autounattend.xml",
    "/home/arombaut/packer/packer-windows-server-2025/cd/*"
  ]

  communicator = "winrm"
  winrm_username = "Administrator"
  winrm_password = "YourPasswordHere"
}

build {
  sources = ["source.vsphere-iso.windows"]

  provisioner "powershell" {
    inline = [
      "powershell -ExecutionPolicy Bypass -File E:\\scripts\\bootstrap.ps1"
    ]
  }
}