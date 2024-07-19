
resource "aws_subnet" "PrivateSubnet1" {
  vpc_id            = data.aws_vpc.GetVpc.id
  cidr_block        = "10.0.128.0/18"
  availability_zone = "us-east-1a"

  tags = {
    Name = "PrivateSubnet1"
  }
}