
resource "aws_lb" "loadbalancer" {
  name               = "Network-Load-Balancer"
  internal           = false
  load_balancer_type = "network"
  subnets            =  var.subnet_ids

  enable_deletion_protection = true

  tags = {
    Environment = "development"
  }
}

resource "aws_lb_target_group" "asg_target_group" {
  name     = "instance_tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
  deregistration_delay = var.deregistration_delay
}

resource "aws_lb_listener" "asg_tg_listener" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = "443"
  protocol          = "HTTPS"
 
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg_target_group.arn
  }
  
}

#Target group attachment 
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = var.autoscaling_group_id
  alb_target_group_arn   = aws_lb_target_group.asg_target_group.arn
}
