variable "keypair_name" {
    type        = string
}

resource "openstack_compute_keypair_v2" "condabuilder" {
  provider   = openstack
  region     = var.region
  name       = "${var.keypair_name}"
  public_key = file("../../id_rsa.pub")
}