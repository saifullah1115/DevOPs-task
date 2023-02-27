# resource "aws_instance" "web" {
#   ami           = "var.AWS_AMI"
#   instance_type = "t2.micro"
#   #key_name      = aws_key_pair.key-tf.key_name
#   #vpc_security_group_ids = ["${aws_security_group.newgroup-tf.id}"]
#   tags = {
#     Name = "terraform-test"
#   }
# }

module "ec2_module" {
  source = "./module1"
}
