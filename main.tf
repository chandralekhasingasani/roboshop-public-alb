resource "aws_lb" "alb" {
  name               = "${var.PROJECT_NAME}-${var.ENV}-alb-test"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls.id]
  subnets            = var.DEFAULT_SUBNET_ID
  tags = {
    Environment = "${var.PROJECT_NAME}-${var.ENV}-alb"
  }
}

resource "aws_lb_target_group" "tg" {
  name        = "${var.PROJECT_NAME}-${var.ENV}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.DEFAULT_VPC_ID
}

resource "aws_lb_target_group_attachment" "test" {
  count            = length(local.FRONTEND_ALB_IP)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = element(local.FRONTEND_ALB_IP,count.index)
  port             = 80
  availability_zone = "all"
}

resource "aws_lb_listener" "front_end_alb" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}




