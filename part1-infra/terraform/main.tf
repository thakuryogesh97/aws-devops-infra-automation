provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "one" {
  count                  = 4
  ami                    = "ami-0013b4404496ef718"
  instance_type          = "t3.small"
  key_name               = "mykey"
  vpc_security_group_ids = ["sg-051f0918b839aad06"]
  tags = {
    Name = var.instance_names[count.index]
  }
}

variable "instance_names" {
  default = ["control-node", "Dev-1", "test-2", "Monitoring server"]
}

resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "devops-artifacts-${random_id.bucket_id.hex}"
}

resource "random_id" "bucket_id" {
  byte_length = 4
}
