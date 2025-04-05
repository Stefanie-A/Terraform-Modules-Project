resource "aws_instance" "ec2_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.sg.id]
  subnet_id       = aws_subnet.public_subnet[0].id
  tags = {
    Name = "fox"
  }
}

#security group
resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #don't allow all ip address to ssh in prod
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Adjust as necessary
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "var.security_group"
  }
}
#ssh key pair
resource "tls_private_key" "key-pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "ssh-key" {
  key_name   = var.key_name
  public_key = tls_private_key.key-pair.public_key_openssh
}