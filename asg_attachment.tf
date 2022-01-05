// resource "aws_autoscaling_attachment" "asg_attachment_tooling" {
//   autoscaling_group_name = aws_autoscaling_group.tooling-asg.id
//   alb_target_group_arn   = aws_lb_target_group.tooling-tgt.arn
// }




// resource "aws_autoscaling_attachment" "asg_attachment_wordpress" {
//   autoscaling_group_name = aws_autoscaling_group.wordpress-asg.id
//   alb_target_group_arn   = aws_lb_target_group.wordpress-tgt.arn
// }



// resource "aws_autoscaling_attachment" "asg_attachment_nginx" {
//   autoscaling_group_name = aws_autoscaling_group.nginx-asg.id
//   alb_target_group_arn   = aws_lb_target_group.nginx-tgt.arn
// }