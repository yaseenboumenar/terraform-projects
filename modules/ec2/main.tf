
# ------------------------------------------------------------ #
#     Provisioning the EC2 instance that installs wordpress    #
# ------------------------------------------------------------ #

resource "aws_instance" "wordpress-ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id

  # Instead of a static user_data file, we can fill placeholders
  # This passes RDS info to the EC2 instance via user_data to call the shellscript (install-wordpress.sh)
  # install-wordpress.sh installs Apache and PHP + downloads wordpress

  user_data = templatefile("${path.root}/install-wordpress.sh" , {
    port        = var.server_port,
    db_host     = var.db_host
    db_name     = var.db_name
    db_user     = var.username
    db_password = var.password
  })

  vpc_security_group_ids = [aws_security_group.dynamic-sg.id]

  tags = {
    name = "wordpress-ec2"
  }
}

# List of ports we want to allow. We'll auto-describe them in an expression.check "
variable "ports" {
  type    = list(number)
  default = [ 22, 80, 443 ]
}


# Build a list of objects from the ports, each with:
# - from_port, to_port, protocol, and a description (based on the port).
locals {
  ingress_rules = [
    for p in var.ports : {
        description = p == 22 ? "SSH" : p == 80 ? "HTTP" : p == 443 ? "HTTPS" : "Other"
        from_port   = p
        to_port     = p
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

resource "aws_security_group" "dynamic-sg" {
  name        = "dynamic-block-sg"
  description = "Security Group using dynamic blocks"
# vpc_id      = "vpc-123456"                # used for LocalStack. It won't validate it
  vpc_id      = "vpc-0aa5a1fb481431b50"     


dynamic "ingress" {
    for_each = local.ingress_rules
    content {
        description = ingress.value.description
        from_port   = ingress.value.from_port
        to_port     = ingress.value.to_port
        protocol    = ingress.value.protocol
        cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}