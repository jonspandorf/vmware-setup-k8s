data "vsphere_datacenter" "datacenter" {
  name = var.vcenter_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.requested_datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  count         = var.isClusterAKnown ? 1 : 0
  name          = var.vcenter_cluster_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_host" "requested_host" {
  count         = var.isHostKnown ? 1 : 0
  name          = var.esxi_host
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_resource_pool" "vcenter_rp" {
  name          = var.requested_rp
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "public_network" {
  name          = var.provider_network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "vm_template" {
  name          = var.template_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
