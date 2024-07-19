resource "aws_eip" "CustomEIP" {
  vpc = true
  tags = {
    Name = "CustomEIP"
  }
}