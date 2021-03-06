provider "aws" {
  region= var.region
}

terraform{
    required_version = "0.12.29"
}

data "terraform_remote_state" "tfstatefile" {
  backend= "s3"
  config = {
    key    =""
    bucket = "tfstatebucket"
    region = var.region
  }
}


module "vpc" {
  source= "./resource_modules/vpc"
  name= "assignment_vpc"
  vpc_cidr= var.vpc_cidr
  private_subnet= var.private_subnet
  public_subnets= var.public_subnets
}

module "asg" {
  source= "./resources_modules/asg"
  name                      = "asg-assignment"
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  force_delete              = true
  placement_group           = var.placement_group
  launch_configuration      = aws_launch_configuration.launch_config.name
  vpc_zone_identifier       = flatten(var.subnet_ids)
  security_group            = aws_security_group.autoscale_sg.security_group_id
}
module "load_balancer" {
  source= "./resources_modules/load_balancer"
  subnets            =  data.terraform_remote_state.outputs.public_subnets_ids
  vpc_id             = data.terraform_remote_state.outputs.vpc_id
  
}