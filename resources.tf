resource "aws_spot_instance_request" "ec2_instance" {
  key_name                    = var.ssh_key_name
  associate_public_ip_address = true
  wait_for_fulfillment        = true
  ami                         = var.ami
  spot_price                  = var.spot_price_max
  spot_type                   = "one-time"
  instance_type               = var.inst_type
  provisioner "local-exec" {
    command = "sleep 30; ssh-keyscan -t rsa ${aws_spot_instance_request.ec2_instance.public_dns} >> ~/.ssh/known_hosts; ssh-keyscan -t rsa ${aws_spot_instance_request.ec2_instance.public_ip} >> ~/.ssh/known_hosts"
  }
}
