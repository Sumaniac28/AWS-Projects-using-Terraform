data "aws_vpc" "GetVpc" {
  filter {
    name   = "tag:Name"
    values = ["CustomVPC"]
  }
}

data "aws_internet_gateway" "GetIGW" {
  filter {
    name   = "tag:Name"
    values = ["IGW"]
  }
}