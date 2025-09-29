resource "aws_lb" "myloadbal" {
  name               = "hox"
  internal           = false
  load_balancer_type = "application"
  subnets            = [for subnet in aws_subnet.public_subnet : subnet.id]
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

resource "aws_lb_target_group" "target_group" {
  name     = "target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id


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
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_target_group_attachment" "tg-attach" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.ec2_instance.id
  port             = 80
  depends_on       = [aws_autoscaling_group.autoscaling_group]
}
