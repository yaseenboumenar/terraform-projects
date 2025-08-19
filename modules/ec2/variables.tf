
variable "ami" {
  type    = string
  default = "ami-042b4708b1d05f512"                      #   "ami-12345678" - Use LocalStack default or override from root
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "server_port" {
  description = "The port Apache/WordPress will run on"
  type        = number
  default     = 80
}

variable "db_host" {
  description = "The endpoint(host) of the RDS database"
  type        = string 
}

variable "db_name" {
  description = "The name of the WordPress database"
  type        = string 
}

variable "username" {
  description = "The username for the database"
  type        = string 
}

variable "password" {
  description = "The password for the database"
  type        = string 
}

variable "vpc_id" {
  description = "The VPC ID where the EC2 should be deployed"
  type        = string
}

variable "key_name" {
  description = "Name of the EC2 key pair for SSH"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet in which to launch the EC2 instance"
  type        = string
  default     = "subnet-06cf4d44d41eff7c1"
}

