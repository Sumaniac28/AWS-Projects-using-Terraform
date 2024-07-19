resource "aws_nat_gateway" "CustomNAT" {
  allocation_id = aws_eip.CustomEIP.id
  subnet_id     = data.aws_subnet.GetPublicSubnet1.id

  tags = {
    Name = "CustomNAT"
  }
}