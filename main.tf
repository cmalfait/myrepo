#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-eea9f38e
#
# Your subnet ID is:
#
#     subnet-b30f9ceb
#
# Your security group ID is:
#
#     sg-834d35e4
#
# Your Identity is:
#
#     autodesk-wolf
#
terraform {
  backend "atlas" {
    name = "malfaic/training"
  }
}

variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

variable "aws_region" {
  default = "us-west-1"
}

variable "zones" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "count" {
  default = "3"
}

provider "aws123" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  count                  = "${var.count}"
  ami                    = "ami-eea9f38e"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-b30f9ceb"
  vpc_security_group_ids = ["sg-834d35e4"]

  tags {
    "Identiity" = "autodesk-wolf"
    "Name"      = "web ${count.index+1}/${var.count}"
    "MyTag1"    = "Foo"
    "MyTag2"    = "Bar"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
