# terraform_ec2_spot_instance
Use terraform to create an EC2 spot instance

## Execution
* Edit this file first: [example.tfvars](example.tfvars)
* * See below on how to find the AMI value
* **Create:** terraform apply -var-file="example.tfvars"
* **Remove:** terraform destroy -var-file="example.tfvars"

## Special Note
The [resources.tf](resources.tf) file contains the following code to modify the local `known_hosts` file, which allows `ssh` to operate without being prompted to accept a new ssh key.  If you don't `sleep` first, the instance might not be ready to accept ssh connections leading to a failure.  **This has only been tested on Linux.**

```
provisioner "local-exec" {
    command = "sleep 30; ssh-keyscan -t rsa ${aws_spot_instance_request.ec2_instance.public_ip} >> ~/.ssh/known_hosts"
}
```
* See also: https://en.wikibooks.org/wiki/OpenSSH/Client_Configuration_Files#~/.ssh/known_hosts

## AMI Discovery

Get a filtered list of AMIs:

```shell
# get a subset of available images in the specified region
aws ec2 describe-images --region ap-south-1 --filters "Name=name,Values=Fedora-Cloud-Base-35*" > Fedora-Cloud-Base-35-ap-south-1.json

# select images that are:
#   in the ap-south-1 region
#   Fedora 35
#   are not Beta
#   use the x86_64 architecture
#   use gp2 EBS
jq -r '.Images | .[] | select(.Name|test("35-[^B].*x86_64.*gp2")) | .Name,.CreationDate,.ImageId,""' Fedora-Cloud-Base-35-ap-south-1.json
```

Example output:

```shell
Fedora-Cloud-Base-35-20211125.0.x86_64-hvm-ap-south-1-gp2-0
2021-11-25T09:04:12.000Z
ami-034b23ed61660ef2f

Fedora-Cloud-Base-35-1.1.x86_64-hvm-ap-south-1-gp2-0
2021-10-20T09:15:32.000Z
ami-03c12ffc26f272061

Fedora-Cloud-Base-35-20211124.0.x86_64-hvm-ap-south-1-gp2-0
2021-11-24T09:00:43.000Z
ami-05f31878a7323235a

Fedora-Cloud-Base-35-20211121.0.x86_64-hvm-ap-south-1-gp2-0
2021-11-21T09:07:24.000Z
ami-07c986d3a0bf92d5b

Fedora-Cloud-Base-35-1.2.x86_64-hvm-ap-south-1-gp2-0
2021-10-26T08:54:14.000Z
ami-0a60b5e120358751c
```
