output "pub_subnet_1" {
  value       = "aws_subnet.PublicSubnet1.id"
  description = "The ID of the Public Subnet 1"
}

output "pub_subnet_2" {
  value       = "aws_subnet.PublicSubnet2.id"
  description = "The ID of the Public Subnet 2"
}

output "pub_route_table" {
  value       = "aws_route_table.PublicRouteTable.id"
  description = "The ID of the Public Route Table"
}