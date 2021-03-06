output "vpc_id" {
  description = "THe ID of VPC"
  value       = aws_vpc.vpc_assignment.id
  }

  output "private_subnets_ids" {
 description = "List of private subnets ID's"
 value =      aws_subnet.private_subnet.*.id
  }

  output "public_subnets_ids" {
 description = "List of  public subnets ID's"
 value =      aws_subnet.public_subnet.*.id
  }
  
  output "vpc_cidr_block" {
    description = "CIDR Block of VPC"
    value = aws_vpc.vpc_assignment.vpc_cidr_block
  }
 