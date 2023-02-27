resource "aws_instance" "web" {
  ami           = "ami-0557a15b87f6559cf"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = ["${aws_security_group.newgroup-tf.id}"]
  tags = {
    Name = "terraform module test"
  }
}

resource "aws_key_pair" "key-tf" {
  key_name   = "key-tf"
  //file("${path.module}/aws_key.pub")
  public_key = file("aws_key.pub")
}


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
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_tls"
  }
}