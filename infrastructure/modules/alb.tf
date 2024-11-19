resource "aws_launch_configuration" "servers" {
  image_id        = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.main_sg.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "aws-3tier" {
  launch_configuration = aws_launch_configuration.server.name
  vpc_zone_identifier  = aws_subnets.private_subnet.ids
  target_group_arns    = [aws_lb_target_group.t-group.arn]
  health_check_type    = "ELB"
  min_size             = 1
  max_size             = 3
  tag {
    key                 = "Name"
    value               = "pox"
    propagate_at_launch = true
  }
}

resource "aws_lb" "myloadbal" {
  name               = "hox"
  load_balancer_type = "application"
  subnets            = aws_subnets.public_subnet.ids
  security_groups    = [aws_security_group.sg.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.myloadbal.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }

}

resource "aws_lb_target_group" "t-group" {
  name     = "target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "rule" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100
  condition {
    path_pattern {
      values = ["*"]
    }
  }
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.t-group.arn
  }
}
