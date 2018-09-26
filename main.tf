module "instances" {
    source = "ecs-module"
    instance_count = 5   # 实例个数
    cpu_core_count = 16  # 实例CPU
    memory_size = 16     # 实例内存
    system_size = 500    # 实例系统磁盘大小
    instance_password = "Admin123"              # root用户的密码
    vpc_id = "vpc-2ze2ic1xgpkwad0catxtt"        # VPC ID
    vswitch_id = "vsw-2zejgd6bn6a4pzffdipj3"    # VSwitch ID
}
