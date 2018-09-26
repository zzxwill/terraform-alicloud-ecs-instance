# ECS
output "hostname_list" {
  value = "${join(",", alicloud_instance.paas.*.instance_name)}"
}

output "ecs_ids" {
  value = "${join(",", alicloud_instance.paas.*.id)}"
}

output "ecs_public_ip" {
  value = "${join(",", alicloud_eip.default.*.ip_address)}"
}