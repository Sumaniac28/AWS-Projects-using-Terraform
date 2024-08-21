variable "AWS_Region" {
  default = "us-east-1"
}

data "aws_vpc" "GetVPC" {
  filter {
    name   = "tag:Name"
    values = ["CustomVPC"]
  }
}

data "aws_instances" "ec2_lst" {
  instance_state_names = ["running"]
}

data "aws_subnets" "GetSubnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.GetVPC.id]
  }

  filter {
    name   = "tag:type"
    values = ["Public"]
  }
}

resource "aws_lb" "CustomELB" {
  name            = "CustomELB"
  subnets         = data.aws_subnets.GetSubnet.ids
  security_groups = [aws_security_group.elb_sg.id]

  tags = {
    Name = "CustomELB"
  }
}

resource "aws_lb_listener" "CustomELBListener" {
  load_balancer_arn = aws_lb.CustomELB.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_lb_target_group.CustomTG.arn
      }
      stickiness {
        enabled  = true
        duration = 28800
      }
    }
  }
}

