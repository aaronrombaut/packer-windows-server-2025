variable "vcenter_server" {}
variable "vcenter_username" {}
variable "vcenter_password" {
  sensitive = true
}

variable "datacenter" {}
variable "cluster" {}
variable "datastore" {}
variable "network" {}

variable "vm_name" {
  default = "win2025-template"
}

variable "winrm_username" {
  default = "Administrator"
}

variable "winrm_password" {
  sensitive = true
}

vcenter_server   = "vcsa-v107-10.lab.aaronrombaut.com"
vcenter_username = "administrator@vsphere.local"
vcenter_password = "IT$h0uldB$3cure!"

datacenter = "New York"
cluster    = "Home Lab Cluster"
datastore  = "virtual-machines"
network    = "dvPG-VLAN107-VM Management"

vm_name = "win2025-test"

winrm_username = "Administrator"
winrm_password = "changeme123!" 