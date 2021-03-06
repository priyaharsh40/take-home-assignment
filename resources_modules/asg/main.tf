#launch configuration
resource "aws_launch_configuration" "launch_config" {
  name          = "launchconfiguration"
  image_id      =  var.image_id
  instance_type = "t2.micro"
}
#security group 
resource "aws_security_group" "autoscale_sg" {
   name        = "sg_asg"
   vpc_id      = data.terraform_remote_state.tfstatefile.outputs.vpc_id

  ingress =[
    {
   
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = data.terraform_remote_state.tfstatefile.outputs.vpc_cidr_block
  },
   {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = data.terraform_remote_state.tfstatefile.outputs.vpc_cidr_block
  }
  ]
  egress = [ 
    { from_port= 80
      to_port= 80
      protocol= "TCP"
      cidr_blocks= "0.0.0.0/0"
      },
      {
      from_port= 443
      to_port= 443
      protocol="TCP"
      cidr_blocks= "0.0.0.0/0"
  } 
  ]

  
}
#autoscaling_group
resource "aws_autoscaling_group" "asg" {
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
  tag {
         name= "autoscaling_group"
  }

  timeouts {
    delete = "15m"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_target_group" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  alb_target_group_arn   = var.target_group_arn
}

