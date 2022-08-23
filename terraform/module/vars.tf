variable "VCENTER_USER" {}

variable "VCENTER_PASSWD" {}

variable "VCENTER_HOST" {}

variable "vcenter_datacenter" {
  description = "name of the datacenter in your vcenter server"
  type        = string
  default     = ""

}

variable "default_gw" {
  description = "the default gateway for each node"
  type        = string
  default     = ""
}


variable "requested_datastore" {
  description = "name of the datastore on vcenter"
  type        = string
  default     = ""
}

variable "requested_rp" {

  description = "name of the resource pool to create"
  type        = string
  default     = ""

}

variable "masters" {
  description = "number of master nodes per cluster. this is a standard k8s installation"
  type = number 
  default = 1 
}

variable "workers" {
  description = "number of worker nodes per cluster"
  type = number 
  default = 3 
}

variable "static_ips" {
  description = "name of the ips"
  type        = list(any)
  default     = []

}

variable "vcenter_cluster_name" {
  type    = string
  default = "RND-Cluster"
}

variable "template_name" {
  description = "name of the ubuntu template in vcenter"
  type        = string
  default     = ""
}

variable "vm_name" {
  type    = string
  default = ""
}

variable "vm_cpus" {
  type    = number
  default = 2

}

variable "hostnames" {
  description = "the hostname for each node"
  type        = list
  default     = []
}

variable "vm_ram" {
  type    = number
  default = 2048
}

variable "static_ip" {

  type    = string
  default = ""

}

variable "static_vars" {
  type = map(any)
  default = {
    username       = "${var.username}"
    password       = base64encode(var.password)
    ipaddress      = element(var.static_ips, count.index)
    defaultgateway = "${var.default_gw}"
  }
}

variable "dhcp_vars" {
  type = map(any)
  default = {
    username = "${var.username}"
    username = "${var.username}"
  }
}

variable "disk_size" {
  type    = number
  default = 20
}

variable "username" {
  type    = string
  default = "user"
}

variable "isClusterKnown" {
  type    = bool
  default = true
}

variable "isHostKnown" {
  type    = bool
  default = false
}

variable "esxi_host" {
  type    = string
  default = ""
}


variable "is_dhcp" {
  type    = bool
  default = false
}

variable "provider_network" {
  type    = string
  default = "VM Network"
}