
output "instance_public_ip" {
  value = module.ec2.instance_public_ip
}

output "instance_private_ip" {
  value = module.ec2.instance_private_ip
}

output "instance_public_dns" {
  value = module.ec2.instance_public_dns
}

output "instance_ec2_sg_id" {
  value = module.ec2.ec2_sg_id
}