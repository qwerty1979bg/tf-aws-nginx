# Define the variables
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "key_name" {}

variable "ami_name" {
  default = "ami-04681a1dbd79675a5"
}

# Configure the AWS Provider
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "us-east-1"
}

# Create an NGINX server
resource "aws_spot_instance_request" "el_ngino" {
  ami           = "${var.ami_name}"
  instance_type = "t3.nano"

  key_name = "${var.key_name}"

  #  spot_price           = "0.0035"
  wait_for_fulfillment = true
  spot_type            = "one-time"

  root_block_device {
    #    device_name           = "/dev/xvda"
    volume_type           = "standard"
    delete_on_termination = true
  }

  user_data = <<EOF
#cloud-config 
packages:
 - nginx

runcmd:
- sudo amazon-linux-extras install nginx1.12
- sudo systemctl enable nginx
- sudo systemctl start nginx
EOF

  # Workaround for the Cloud-init
  connection {
    user        = "ec2-user"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait ; exit 0",
    ]
  }
}

output "connect_here" {
  value = ["${aws_spot_instance_request.el_ngino.public_ip}"]
}
