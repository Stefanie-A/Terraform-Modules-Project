data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "as_conf" {
  name          = "web_config"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
}

resource "aws_launch_configuration" "servers" {
  name          = "server-config"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
}


resource "aws_launch_template" "launch_template" {
  name          = "web_template"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name

  lifecycle {
    create_before_destroy = false
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    device_index                = 0
    security_groups             = [aws_security_group.sg.id]
  }
}
resource "aws_autoscaling_group" "autoscaling_group" {
  min_size                  = 2
  max_size                  = 3
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.servers.name
  vpc_zone_identifier       = [for subnet in aws_subnet.private_subnet : subnet.id]
  target_group_arns         = [aws_lb_target_group.target_group.arn]

  tag {
    key                 = "Name"
    value               = "pox"
    propagate_at_launch = true
  }
}