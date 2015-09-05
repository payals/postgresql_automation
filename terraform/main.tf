provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

resource "aws_instance" "db" {
  connection {
    user = "ubuntu"
    key_file = "${var.key_path}"
  }

  instance_type = "m1.small"
  security_groups = ["payal-test"] 
  count = 2

  ami = "${lookup(var.aws_amis, var.aws_region)}"

  key_name = "${var.key_name}"

}
