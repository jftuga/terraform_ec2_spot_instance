# terraform_ec2_spot_instance
Use terraform to create an EC2 spot instance

This *README* file is currently a **work in progress.**

## Execution
* edit: `example.tfvars`
* terraform apply -var-file="example.tfvars"
* terraform destroy -var-file="example.tfvars"

## AMI Discovery

* aws ec2 describe-images --region ap-south-1 --filters "Name=name,Values=Fedora-Cloud-Base-35*" > Fedora-Cloud-Base-35-ap-south-1.json
* grep "Name.*2021.*x86_64.*gp2" Fedora-Cloud-Base-35-ap-south-1.json
