resource "local_file" "AnsibleInventory" {
  content = templatefile(
    "${path.module}/templates/inventory.tmpl",
    {
      user              = "${var.username}"
      password          = "${var.password}"
      masters_hostnames = slice(var.hostnames, 0, 1)
      workers_hostnames = slice(var.hostnames, 1, length(var.hostnames))
      masters           = "${vsphere_virtual_machine.masters.*.default_ip_address}"
      workers           = "${vsphere_virtual_machine.workers.*.default_ip_address}"
    }
  )

  filename = "./inventory-${cluster_num}.txt"
}





