variable "max_size" {
  description = "The maximum size of the Auto Scaling Group."
}

variable "min_size" {
  description = "The minimum size of the Auto Scaling Group."
}

variable "subnet_ids" {
  description = "Subnet id in which vpc is hosted "
  }

variable "target_group_arn" {
  description = "ARN of target group"
}
variable "image_id" {
  description = "image id of instances"
}