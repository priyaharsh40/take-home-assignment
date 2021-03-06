variable "public_subnet_cidr" {
  description = "Public Subnet CIDR block "
  type = "list"
  default = []
}
variable "private_subnet_cidr" {
  description = "Private Subnet CIDR block"
  type = "list"
  default = []
}
variable "instance_tenancy" {
    description = "A tenancy option for instances launched into the VPC."
    default = "default"
}
variable "vpc_cidr" {
  description = "CIDR Block Of VPC"
  default =  "0.0.0.0/0"
}