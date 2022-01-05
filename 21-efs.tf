# create key from key management system
resource "aws_kms_key" "prj-15-kms" {
  description = "KMS key"
  policy      = <<EOF
  {
  "Version": "2012-10-17",
  "Id": "kms-key-policy",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": { "AWS": "arn:aws:iam::957405565157:user/topesan" },
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
EOF
}

# create key alias
resource "aws_kms_alias" "alias" {
  name          = "alias/kms"
  target_key_id = aws_kms_key.prj-15-kms.key_id
}

# create Elastic file system
resource "aws_efs_file_system" "old-cowboy-efs" {
  encrypted  = true
  kms_key_id = aws_kms_key.prj-15-kms.arn

  tags = {
    Name            = "project-15-old-cowboy-file-system"
    Enviroment      = "production"
    Owner-Email     = "infradev@teadservices.com"
    Managed-By      = "Terraform"
    Billing-Account = "1234567890"
  }

}





# set first mount target for the EFS 
resource "aws_efs_mount_target" "subnet-1" {
  file_system_id  = aws_efs_file_system.old-cowboy-efs.id
  subnet_id       = aws_subnet.PrivateSubnet-1.id
  security_groups = [aws_security_group.datalayer-sg.id]
}


# set second mount target for the EFS 
resource "aws_efs_mount_target" "subnet-2" {
  file_system_id  = aws_efs_file_system.old-cowboy-efs.id
  subnet_id       = aws_subnet.PrivateSubnet-2.id
  security_groups = [aws_security_group.datalayer-sg.id]
}


# create access point for wordpress
resource "aws_efs_access_point" "wordpress" {
  file_system_id = aws_efs_file_system.old-cowboy-efs.id

  posix_user {
    gid = 0
    uid = 0
  }

  root_directory {
    path = "/wordpress"

    creation_info {
      owner_gid   = 0
      owner_uid   = 0
      permissions = 0755
    }

  }

}


# create access point for tooling
resource "aws_efs_access_point" "tooling" {
  file_system_id = aws_efs_file_system.old-cowboy-efs.id
  posix_user {
    gid = 0
    uid = 0
  }

  root_directory {

    path = "/tooling"

    creation_info {
      owner_gid   = 0
      owner_uid   = 0
      permissions = 0755
    }

  }
}
