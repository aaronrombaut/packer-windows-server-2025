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
  insecure_connection  = true

  datacenter           = "New York"
  cluster              = "Home Lab Cluster"
  datastore            = "virtual-machines"

  vm_name              = "win2025-test"
  guest_os_type        = "windows9Server64Guest"

  CPUs                 = 2
  RAM                  = 4096

  network_adapters {
    network = "dvPG-VLAN107-VM Management"
  }

  disk_controller_type = ["lsilogic-sas"]
  storage {
    disk_size             = 40960
    disk_thin_provisioned = true
  }

#  iso_paths = ["[YOUR_DATASTORE] iso/windows2025.iso"]
  iso_paths = ["General Purpose/26100.32230.260111-0550.lt_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso"]

  floppy_files = ["autounattend.xml"]

  communicator = "winrm"
  winrm_username = "Administrator"
  winrm_password = "YourPasswordHere"
}

build {
  sources = ["source.vsphere-iso.windows"]
}