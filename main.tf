provider "aws" {
  region = "${var.region}"
}

module "security_groups" {
  source = "./security_groups"
}

module "instances" {
  source              = "./instances"
  key_name            = "${var.key_name}"
  security_group_name = "${module.security_groups.security_group_name}"
}
