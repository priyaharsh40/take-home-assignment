output "autoscaling_group_id" {
  description = "ID of the autscaling group"
  value = aws_launch_configuration.default.*.id
}

output "autoscaling_group_arn" {
  value = aws_launch_configuration.default.*.arn
}
output "security_group_id" {
  value = aws_security_group.autoscale_sg.id
}