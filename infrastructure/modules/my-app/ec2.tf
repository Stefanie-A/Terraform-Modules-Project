resource "aws_instance" "ec2_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.sg.id]
  subnet_id     = var.pub_subnets_cidr[0]
  tags = {
    Name = "fox"
  }
}