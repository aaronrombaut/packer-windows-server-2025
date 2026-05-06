packer {
  required_plugins {
    vsphere = {
      source  = "github.com/hashicorp/vsphere"
      version = ">= 1.0.0"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.0.0"
    }
  }
}

source "vsphere-iso" "windows" {
  vcenter_server       = var.vcenter_server
  username             = var.vcenter_username
  password             = var.vcenter_password
  insecure_connection  = false

  datacenter           = var.datacenter
  cluster              = var.cluster
  datastore            = var.datastore

  vm_name              = var.vm_name
  guest_os_type        = "windows2019srvNext_64Guest"

  CPUs                 = 2
  RAM                  = 8192

  video_ram            = 256000
  
  firmware             = "efi-secure"
  vm_version           = 19
  boot_wait            = "3s"
  boot_command = [
    "<enter>"
  ]

  network_adapters {
    network = var.network
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
  winrm_insecure = true
  winrm_use_ssl = false
  winrm_username = var.winrm_username
  winrm_password = var.winrm_password
  winrm_timeout = "30m"
}

build {
  sources = ["source.vsphere-iso.windows"]

  provisioner "ansible" {
    playbook_file = "ansible/playbooks/test.yaml"
    
    extra_arguments = [
      "-e", "ansible_connection=winrm",
      "-e", "ansible_winrm_transport=basic",
      "-e", "ansible_winrm_server_cert_validation=ignore",
      "-e", "ansible_user=Administrator",
      "-e", "ansible_password=${var.winrm_password}"
    ]
  }
}