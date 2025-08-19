
# ------------------------------------------------------------ #
#  RDS instance (now commented - as we're mocking DB locally)  #
# ------------------------------------------------------------ #

# resource "aws_db_instance" "wordpress-rds-db" {
#   allocated_storage   = var.allocated_storage
#   engine              = var.engine
#   engine_version      = var.engine_version
#   instance_class      = var.instance_class
#   db_name             = var.db_name
#   username            = var.username
#   password            = var.password
#   skip_final_snapshot = true
#   publicly_accessible = true
# }

resource "aws_security_group" "rds-sg" {
  name = "wordpress-rds-sg"
  description = "Allow MySQL access from EC2"
# vpc_id      = "vpc-123456"                # used for LocalStack. It won't validate it
  vpc_id      = "vpc-0aa5a1fb481431b50" 

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    
    # Allow only EC2 security group to connect
    security_groups = [var.instance_ec2_sg_id]
  }

  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 }
}