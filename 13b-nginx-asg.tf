resource "aws_autoscaling_group" "nginx-asg" {
  name                      = "nginx-asg"
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1

  vpc_zone_identifier = [
    aws_subnet.PrivateSubnet-1.id,
    aws_subnet.PrivateSubnet-2.id
  ]


  launch_template {
    id      = aws_launch_template.nginx-launch-template.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "p15-nginx"
    propagate_at_launch = true
  }

}
