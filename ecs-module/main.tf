provider "terraform" {}
# Configure the Alicloud Provider
provider "alicloud" {
}

resource "alicloud_eip" "default" {
  bandwidth = 1
}

// Instance_types data source for instance_type
data "alicloud_instance_types" "default" {
  cpu_core_count = "${var.cpu_core_count}"
  memory_size    = "${var.memory_size}"
}

// Zones data source for availability_zone
data "alicloud_zones" "default" {
  available_disk_category = "${var.disk_category}"
  available_instance_type = "${data.alicloud_instance_types.default.instance_types.0.id}"
}

resource "alicloud_eip_association" "default" {
  allocation_id = "${alicloud_eip.default.id}"
  instance_id = "${alicloud_instance.paas.id}"
}

# Create security group
resource "alicloud_security_group" "sg" {
  name        = "default"
  provider    = "alicloud"
  vpc_id = "${alicloud_vpc.vpc.id}"
  description = "default"
}

resource "alicloud_security_group_rule" "allow_all_tcp" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 1
  security_group_id = "${alicloud_security_group.sg.id}"
  cidr_ip           = "0.0.0.0/0"
}

# ECS
resource "alicloud_instance" "paas" {
  provider          = "alicloud"
  image_id          = "m-2ze3xm2ph7d4wdn4nfy0"
  internet_charge_type  = "PayByTraffic"
  # instance_type        = "ecs.g5.large"
  instance_type     = "${data.alicloud_instance_types.default.instance_types.0.id}"
  system_disk_category = "${var.disk_category}"
  system_disk_size     = "${var.system_size}"
  security_groups      = ["${alicloud_security_group.sg.id}"]
  instance_name        = "paas"
  vswitch_id = "${alicloud_vswitch.vsw.id}"
  count = "${var.instance_count}"
  password = "${var.instance_password}"

}

resource "alicloud_vpc" "vpc" {
  name       = "paas"
  cidr_block = "${var.cidr_block_vpc}"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "${var.cidr_block_vswitch}"
  # availability_zone = "${var.availability_zone}"
  availability_zone = "${data.alicloud_zones.default.zones.0.id}"
}

