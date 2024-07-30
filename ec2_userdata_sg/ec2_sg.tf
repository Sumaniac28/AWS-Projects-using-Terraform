resource "aws_security_group" "CustomSG" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = data.aws_vpc.GetVPC.id

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
    Name = "CustomSG"
  }
}

resource "aws_instance" "CustomEC2" {
  count           = length(data.aws_subnets.GetPublicSubnet.ids)
  ami             = lookup(var.ami, var.AWS_REGION)
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.CustomSG.id]
  subnet_id       = data.aws_subnets.GetPublicSubnet.ids[count.index]
  user_data = <<EOF
    #! /bin/bash
    sudo su
    sudo yum update
    sudo yum install -y httpd
    sudo chkconfig httpd on
    sudo service httpd start
    echo "<h1>Deployed EC2 With Terraform</h1>" | sudo tee /var/www/html/index.html
    EOF

  tags = {
    Name = "CustomEC2"
    ENV  = "Dev"
  }
}