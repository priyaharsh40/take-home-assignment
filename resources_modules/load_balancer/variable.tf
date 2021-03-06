variable "subnet_ids" {
  description = "THe subnets nlb is hosted in"
  type = list(string)
}

variable "vpc_id" {
  description = "Id of VPC to which nlb is attached"
}

variable "deregistration_delay" {
  description = "The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused."
  
}

variable "autoscaling_group_id" {
  description = "ID of  ASG to associate with the ELB."
}