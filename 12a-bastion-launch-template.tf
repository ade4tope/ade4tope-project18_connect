


# launch template for bastion

resource "aws_launch_template" "bastion-launch-template" {
  name = "p15-bastion"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }


  image_id = "ami-0b0af3577fe5e3532"

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  key_name = "p15-key-mac-mini"


  monitoring {
    enabled = true
  }

  placement {
    availability_zone = "us-east-1a"
  }


  vpc_security_group_ids = [aws_security_group.bastion-sg.id]

  tag_specifications {
    resource_type = "instance"


    tags = {
      Name            = "bastion-launch-template"
      Enviroment      = "production"
      Owner-Email     = var.owner_email
      Managed-By      = "Terraform"
      Billing-Account = "1234567890"
    }
  }

  user_data = filebase64("${path.module}/bin/bastion.sh")
  //  user_data =  file("./bin/bastion.sh")
}