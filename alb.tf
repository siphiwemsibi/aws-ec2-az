
# resource "aws_alb" "alb" {
#   name = var.alb_name
#   internal = true
#   load_balancer_type = "application"
#   security_groups = []
#   subnets = []

#   enable_deletion_protection = 

#   access_logs {
#     bucket = 
#     prefix = 
#     enabled = true
#   }

#   tags = {
#     Name = var.alb_name
#   }
# }
