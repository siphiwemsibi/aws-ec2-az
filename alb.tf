
resource "aws_alb" "alb" {
  name               = var.alb_name
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.firco_alb_sec.id]
  subnets            = var.subnet_ids

  enable_deletion_protection = true

#   access_logs {
#     bucket  = "firco-tfstate-bucket-us"
#     prefix  = "firco-alb-http"
#     enabled = true
#   }

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_target_group" "firco_alb_target" {
  name     = "firco-instance-backend"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.firco_vpc.id
}

resource "aws_alb_listener" "firco_alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.firco_alb_target.arn

  }
}

resource "aws_alb_target_group_attachment" "firco_alb_target_attach" {
  count            = length(aws_instance.firco_ec2)
  target_group_arn = aws_lb_target_group.firco_alb_target.arn
  target_id        = aws_instance.firco_ec2[count.index].id
  port             = "80"
}
