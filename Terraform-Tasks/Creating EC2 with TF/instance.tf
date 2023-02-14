
#creating ssh key

resource "aws_key_pair" "key-tf" {
  key_name   = "key-tf"
  public_key = file("${path.module}/id_rsa.pub")
}

#creating security group

resource "aws_security_group" "newgroup-tf" {
  name        = "newgroup-tf"
  description = "new group from terraform"

  dynamic "ingress" {
    for_each = [22, 80, 443]
    iterator = port
    content {
      description = "terraform dynamic loop for ports"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

#creating EC2

resource "aws_instance" "web" {
  ami                    = "ami-0aa7d40eeae50c9a9"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = ["${aws_security_group.newgroup-tf.id}"]
  tags = {
    Name = "terraform-test"
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/xoobdevops/Desktop/terraform-tasks/terraform-ec2/id_rsa")
      timeout     = "2m"
   }
}