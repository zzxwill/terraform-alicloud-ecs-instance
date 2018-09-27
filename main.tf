module "instances" {
    source = "ecs-module"
    vpc_id = "${var.vpc_id}"                        # VPC ID
    vswitch_id = "${var.vswitch_id}"                # VSwitch ID
    instance_count = "${var.instance_count}"        # 实例个数
    cpu_core_count = "${var.cpu_core_count}"        # 实例CPU
    memory_size = "${var.memory_size}"              # 实例内存
    disk_category = "${var.disk_category}"          # 实例类型
    system_size = "${var.system_size}"              # 实例系统磁盘大小
    instance_password = "${var.instance_password}"  # root用户的密码
}
