resource "aws_lb_target_group" "CustomTG" {
  name        = "CustomTG"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.GetVPC.id
  target_type = "instance"
}

resource "aws_lb_target_group_attachment" "CustomTGAttachment" {
  count            = length(data.aws_instances.ec2_lst.ids)
  target_group_arn = aws_lb_target_group.CustomTG.arn
  target_id        = data.aws_instances.ec2_lst.ids[count.index]
  port             = 80
}

resource "aws_security_group" "elb_sg" {
  name        = "allow_http_elb"
  description = "Allow HTTP inbound traffic for ELB"
  vpc_id      = data.aws_vpc.GetVPC.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-elb-security-group"
  }
}

