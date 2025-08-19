
variable "allocated_storage" {
  type    = number
  default = 10
}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type    = string
  default = "5.7"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_name" {
  type    = string
  default = "wordpress"
}

variable "username" {
  type    = string
  default = "admin"
}

variable "password" {
  type    = string
  default = "changeme"
}

variable "instance_ec2_sg_id" {
  description = "Security group ID of the EC2 instance"
  type        = string
}
