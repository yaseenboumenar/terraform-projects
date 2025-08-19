
output "ec2_sg_id" {
  value = aws_security_group.dynamic-sg.id
}

output "instance_public_ip" {
  value = aws_instance.wordpress-ec2.public_ip
}

output "instance_private_ip" {
  value = aws_instance.wordpress-ec2.private_ip
}

output "instance_public_dns" {
  value = aws_instance.wordpress-ec2.public_dns
}

