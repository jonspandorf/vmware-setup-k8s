data "template_file" "userdata" {
  count    = length(var.masters + var.clients)
  template = var.is_dhcp ? file("${path.module}/templates/userdata.yaml") : file("${path.module}/templates/userdata-dhcp.yaml")
  vars     = var.is_dhcp ? var.dhcp_vars : var.static_vars
}

resource "vsphere_virtual_machine" "master_node" {

  count = length(var.masters)

  name             = "${var.requested_rp}_master_${count.index + 1}"
  num_cpus         = var.vm_cpus
  memory           = var.vm_ram
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = vsphere_resource_pool.vcenter_rp.id
  guest_id         = data.vsphere_virtual_machine.vm_template.guest_id
  scsi_type        = data.vsphere_virtual_machine.vm_template.scsi_type

  disk {
    label            = "disk0"
    size             = var.disk_size
    thin_provisioned = data.vsphere_virtual_machine.vm_template.disks.0.thin_provisioned
  }

  network_interface {
    network_id   = data.vsphere_network.public_network.id
    adapter_type = data.vsphere_virtual_machine.vm_template.network_interface_types[0]
  }


  cdrom {
    client_device = true
  }

  extra_config = {
    "ethernet0.pciSlotNumber" = "160"
    "disk.EnableUUID"         = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.vm_template.id
  }

  vapp {
    properties = {
      "instance-id" = vsphere_virtual_machine.master_node.name
      "hostname"    = var.hostnames
      "user-data"   = base64encode(data.template_file.userdata[count.index].rendered)
    }
  }

  lifecycle {
    ignore_changes = [
      enable_disk_uuid,
      extra_config
    ]
  }

}

resource "vsphere_virtual_machine" "worker_node" {

  count = length(var.workers)

  name             = "${var.requested_rp}_wokrer_${count.index + 1}"
  num_cpus         = var.vm_cpus
  memory           = var.vm_ram
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.vcenter_rp.id
  guest_id         = data.vsphere_virtual_machine.vm_template.guest_id
  scsi_type        = data.vsphere_virtual_machine.vm_template.scsi_type

  disk {
    label            = "disk0"
    size             = var.disk_size
    thin_provisioned = data.vsphere_virtual_machine.vm_template.disks.0.thin_provisioned
  }

  network_interface {
    network_id   = data.vsphere_network.public_network.id
    adapter_type = data.vsphere_virtual_machine.vm_template.network_interface_types[0]
  }


  cdrom {
    client_device = true
  }

  extra_config = {
    "ethernet0.pciSlotNumber" = "160"
    "disk.EnableUUID"         = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.vm_template.id
  }

  vapp {
    properties = {
      "instance-id" = element(var.hostname, count.index)
      "hostname"    = element(var.hostnames, count.index)
      "user-data"   = base64encode(data.template_file.userdata[count.index].rendered)
    }
  }

  lifecycle {
    ignore_changes = [
      enable_disk_uuid,
      extra_config
    ]
  }

}