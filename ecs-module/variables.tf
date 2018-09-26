# ECS
variable "cidr_block_vpc" {
  default = "10.0.0.0/12"
}

variable "cidr_block_vswitch" {
  default = "10.0.0.0/16"
}

variable "instance_count" {
  default = "1"
}

variable "disk_category" {
  default = "cloud_efficiency"
}

variable "system_size" {
  description = "The system disk size used to launch one or more ecs instances."
  default     = "500"
}

variable "instance_password" {
  default = "Admin123"
}

# Instance typs variables
variable "cpu_core_count" {
  description = "CPU core count used to fetch instance types."
  default     = 1
}

variable "memory_size" {
  description = "Memory size used to fetch instance types."
  default     = 2
}