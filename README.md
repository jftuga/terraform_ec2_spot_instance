# terraform_ec2_spot_instance
Use terraform to create an EC2 spot instance

## Execution
* Edit this file first: `example.tfvars`
* **Create:** terraform apply -var-file="example.tfvars"
* **Remove:** terraform destroy -var-file="example.tfvars"

## Special Note
The `resources.tf` file contains this code to modify the local `known_hosts` file, which allows `ssh` to operate without being prompted to accept a new ssh key.  This has only been tested on a Linux platform.

```
provisioner "local-exec" {
    command = "sleep 30; ssh-keyscan -t rsa ${aws_spot_instance_request.ec2_instance.public_ip} >> ~/.ssh/known_hosts"
}
```

## AMI Discovery

*Work in progress...*

* aws ec2 describe-images --region ap-south-1 --filters "Name=name,Values=Fedora-Cloud-Base-35*" > Fedora-Cloud-Base-35-ap-south-1.json
* grep "Name.*2021.*x86_64.*gp2" Fedora-Cloud-Base-35-ap-south-1.json
