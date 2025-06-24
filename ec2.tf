resource "aws_instance" "test_public" {
  ami           = "ami-01f23391a59163da9" # Ubuntu 20.04 LTS , eu-west-1
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public-subnet-1.id
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  key_name = var.ec2_key  # keypair for macbook.

  tags = {
    Name = "test-public"
  }
}