output "vpc_id" {
  value       = aws_vpc.CustomVPC.id
  description = "This is a vpc id"
}

output "enable_dns_support" {
  value       = aws_vpc.CustomVPC.enable_dns_support
  description = "Check whether dns support is enabled for vpc or not"
}

output "enable_dns_hostnames" {
  value       = aws_vpc.CustomVPC.enable_dns_hostnames
  description = "Check whether dns hostnames are enabled for vpc or not"
}

output "aws_internet_gateway_id" {
  value       = aws_internet_gateway.IGW.id
  description = "This is an internet gateway id"
}