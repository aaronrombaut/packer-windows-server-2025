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