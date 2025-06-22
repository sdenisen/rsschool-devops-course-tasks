output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_1" {
  value = aws_subnet.public-subnet-1.id
}

output "public_subnet_2" {
  value = aws_subnet.public-subnet-2.id
}

output "private_subnet-1" {
  value = aws_subnet.private-subnet-1.id
}

output "private_subnet-2" {
  value = aws_subnet.private-subnet-2.id
}