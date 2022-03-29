variable "flavor_names" {
    type = string
    default = "i1-180"
    //default = ["d2-4", "d2-2", "s1-2"]
}

variable "image_names" {
  type = string
  default = "Ubuntu 21.10"
}

variable "region" {
  type = string
  default = "DE1"
 // default = ["GRA9", "DE1", "GRA9"]
}

variable "ansible_user" {
    type        = string
}

variable "server_count" {
  type = number
  default = 7
}

resource "openstack_compute_instance_v2" osinstance {
   count = var.server_count
   name        = "github-runner-${count.index+1}"
   provider    = openstack
   region = var.region
   image_name  = var.image_names
   flavor_name = var.flavor_names
   
   key_pair    = openstack_compute_keypair_v2.condabuilder.name
   network {
    name      = "Ext-Net"
   }
   metadata = {
     group = "openstack"
     ansible_user = var.ansible_user
   }
}
