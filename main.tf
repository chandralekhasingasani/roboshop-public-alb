resource "aws_lb" "alb" {
  name               = "${var.PROJECT_NAME}-${ENV}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_alb.id]
  subnets            = var.DEFAULT_SUBNET_ID
  tags = {
    Environment = "${var.PROJECT_NAME}-${var.COMPONENT}"
  }
}

resource "aws_lb_target_group" "tg" {
  name        = "${var.PROJECT_NAME}-${ENV}-tg"
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



