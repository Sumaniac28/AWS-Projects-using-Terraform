resource "aws_security_group" "asg_ag" {
  name        = "ASG_Allow_Traffic"
  description = "allow all inbound traffic for asg"
  vpc_id      = data.aws_vpc.GetVPC.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-asg-security-group"
  }
}

resource "aws_lb_target_group" "ASGTG" {
  name        = "ASGTG"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.GetVPC.id
  target_type = "instance"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

resource "aws_launch_configuration" "launch_config_dev" {
  name_prefix                 = "webteir_dev"
  image_id                    = "ami-00448a337adc93c05"
  instance_type               = var.instance_type
  security_groups             = ["${aws_security_group.asg_ag.id}"]
  associate_public_ip_address = true
  user_data                   = <<EOF
#! /bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling_group_dev" {
  launch_configuration = aws_launch_configuration.launch_config_dev.id
  max_size             = 2
  min_size             = 4
  target_group_arns    = ["${aws_lb_target_group.ASGTG.arn}"]
  vpc_zone_identifier  = data.aws_subnets.GetSubnet.ids

  tag {
    key                 = "Name"
    value               = "autoscaling-group-dev"
    propagate_at_launch = true
  }
}