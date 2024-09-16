variable "AWS_REGION" {
  default = "us-west-2"
}

data "aws_vpc" "GetVPC" {
  filter {
    name   = "tag:name"
    values = ["CustomVPC"]
  }
}

data "aws_subnets" "GetSubnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.GetVPC.id]
  }
  filter {
    name   = "tag:Type"
    values = ["Public"]
  }
}