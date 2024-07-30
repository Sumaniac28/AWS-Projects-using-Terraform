variable "AWS_REGION" {
  default = "us-east-1"
}

data "aws_vpc" "GetVPC" {
  filter {
    name   = "tag:Name"
    values = ["CustomVPC"]
  }
}

data "aws_subnets" "GetPublicSubnet" {
  filter {
    name   = "tag:Name"
    values = ["PublicSubnet1"]
  }
}

variable "ami" {
  type = map(any)
  default = {
    us-east-1 = "ami-0c55b159cbfafe1f0"
    us-west-2 = "ami-0a887e401f7654935"
  }
}